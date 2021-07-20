package com.ryu.chatting.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Delete;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ryu.chatting.model.Chattinglog;
import com.ryu.chatting.model.Room;
import com.ryu.chatting.model.User;
import com.ryu.chatting.model.User2;
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
	
	@PostMapping("/enrollwait")
	public ResponseEntity enrollwait(@RequestParam Map map){
		
		chattingservice.enrollwait(map);
		
		return new ResponseEntity(HttpStatus.OK);
	}
	
	@PostMapping("/deletewait")
	public ResponseEntity deletewait(@RequestParam Map map){

		chattingservice.deletewait(map);
		
		return new ResponseEntity(HttpStatus.OK);
	}
	
	@GetMapping("/searchwait")
	public ResponseEntity searchwait(@RequestParam Map map){
		
		User match = chattingservice.searchwait(map);
		
		if( match != null) {
			return new ResponseEntity(HttpStatus.OK);
		}else {
			return new ResponseEntity(HttpStatus.BAD_REQUEST);
		}
		
		
	}
	
	@GetMapping("/searchrandomroom")
	public ResponseEntity<?> searchrandomroom(@RequestParam Map map){
		
		
		Room random = chattingservice.searchrandomroom(map);
		
		if( random != null) {
			System.out.println("방이있음!");
			return new ResponseEntity<Room>(random,HttpStatus.OK);
		}else {
			
			return new ResponseEntity(HttpStatus.BAD_GATEWAY);
		}
		
		
	}
	
	@PostMapping("/makerandomroom")
	public ResponseEntity<?> makerandomroom(@RequestParam Map map){
		
		
		System.out.println("만들러옴");
		chattingservice.makerandomroom(map);
		
		return new ResponseEntity(HttpStatus.OK);
		
		
		
	}
	


}
