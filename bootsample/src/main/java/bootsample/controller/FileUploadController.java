package bootsample.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bootsample.model.Post;
import bootsample.service.PostService;
import bootsample.service.StorageFileNotFoundException;
import bootsample.service.StorageService;
import bootsample.service.UploadAWSService;

@Controller
public class FileUploadController {

	@Autowired
	private PostService postR;

	private final StorageService storageService;

	@Autowired
	public FileUploadController(StorageService storageService) {
		this.storageService = storageService;
	}

	@GetMapping("/")
	public String listUploadedFiles(Model model) throws IOException {
		model.addAttribute("mode", "MODE_NEW");
//		model.addAttribute("files",
//				storageService.loadAll()
//						.map(path -> MvcUriComponentsBuilder
//								.fromMethodName(FileUploadController.class, "serveFile", path.getFileName().toString())
//								.build().toString())
//						.collect(Collectors.toList()));
		Post post = new Post();
		model.addAttribute("post", post);
		
		return "index";
	}
	

//	@GetMapping("/files/{filename:.+}")
//	@ResponseBody
//	public ResponseEntity<Resource> serveFile(@PathVariable String filename) {
//
//		Resource file = storageService.loadAsResource(filename);
//		return ResponseEntity.ok()
//				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + file.getFilename() + "\"")
//				.body(file);
//	}

	@ExceptionHandler(StorageFileNotFoundException.class)
	public ResponseEntity handleStorageFileNotFound(StorageFileNotFoundException exc) {
		return ResponseEntity.notFound().build();
	}

//	@GetMapping("/{id}")
//	public String findById(@PathVariable("id")Integer id, Model model) {
//		Post post = postR.findOne(id);
//		model.addAttribute("post", post);
//		return "index";
//	}
	
	@PostMapping("/")
	public String insert(ModelMap model,
			@ModelAttribute("post")Post post,@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) throws IOException {
		System.out.println(post.getTitle());
		model.addAttribute("mode", "MODE_NEW");
		/*//drive
		File convFile = storageService.store(file);
		UploadService service = new UploadService();
		String url = service.Upload(convFile);
		model.addAttribute("message", "Upload file thành công! Link: <a href='" + url+"'>"+ file.getOriginalFilename()+"</a>");
		post.setUrl(url);
		postR.save(post);
		System.out.println(post.getId());*/
		File path = storageService.store(file);
		UploadAWSService a=new UploadAWSService();
		a.doUpload(path);
		
		return "index";
	}
	
	@ModelAttribute("posts")
	public List<Post> getDocuments(){
		return (List<Post>) postR.findAll();
	}
	
	//
	@GetMapping("/all-tasks")
	public String allTasks(HttpServletRequest request){
		request.setAttribute("posts", postR.findAll());
		request.setAttribute("mode", "MODE_TASKS");
		return "index";
	}
	
}
