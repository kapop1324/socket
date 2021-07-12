package com.ryu.chatting.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ryu.chatting.model.Chattinglog;
import com.ryu.chatting.model.Room;
import com.ryu.chatting.model.User;
import com.ryu.chatting.model.service.ChattingService;


@org.springframework.web.bind.annotation.RestController
@RequestMapping("/rest")
@CrossOrigin("*")
public class RestController {
	
	@Autowired
	ChattingService chattingservice;
	
	List<Room> roomList = new ArrayList<Room>();
	
	
	@PostMapping("/createRoom")
	public ResponseEntity<List<Room>> createRoom(@RequestParam Map map,HttpServletRequest request){
		
		String roomName = (String) map.get("roomName");
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("loginuser");
		
		HashMap hashmap = new HashMap();
		hashmap.put("title", roomName);
		hashmap.put("master", user.getId());
		
		if(roomName != null && !roomName.trim().equals("")) {

			chattingservice.createroom(hashmap);
			roomList = chattingservice.getroom();
			
		}
		
		
		
		return new ResponseEntity<List<Room>>(roomList,HttpStatus.OK);

	}
	
	@GetMapping("/getRoom")
	public ResponseEntity<List<Room>> getRoom(@RequestParam Map map){
		
		roomList = chattingservice.getroom();
		
		return new ResponseEntity<List<Room>>(roomList,HttpStatus.OK);
	}
	
	@GetMapping("/getmsg")
	public ResponseEntity<List<Chattinglog>> getmsg(@RequestParam Map map){
		
		List<Chattinglog> chattinglog = chattingservice.getmsg(map);
		
		return new ResponseEntity<List<Chattinglog>>(chattinglog,HttpStatus.OK);
	}
	


}
