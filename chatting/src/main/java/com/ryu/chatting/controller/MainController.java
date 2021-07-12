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
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ryu.chatting.model.Room;
import com.ryu.chatting.model.User;
import com.ryu.chatting.model.service.ChattingService;

@Controller
public class MainController {
	
		@Autowired
		ChattingService chattingservice;

		@GetMapping("/chat")
		public String chat() {
			
			return "chat";
		}
		
		@GetMapping("/logout")
		public String logout(HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			session.invalidate();
			
			return "redirect:/";
		}
		
		@GetMapping("/login")
		public String login() {
			
			return "login";
		}
		
		@PostMapping("/login")
		public String postlogin(@RequestParam Map map,HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			
			User user = chattingservice.login(map);
			
			if(user != null) {
				session.setAttribute("loginuser", user);
			}
			
			return "redirect:/";
		}
	
		@GetMapping("/register")
		public String register() {
			
			return "register";
		}
		
		@PostMapping("/register")
		public String postregister(@RequestParam Map map,HttpServletRequest request) {
			
			HttpSession session = request.getSession();
			
			chattingservice.register(map);
			
			
			return "room";
		}
	
		
		@GetMapping("/")
		public String room() {
			
			return "room";
		}
		
		@GetMapping("/moveChating")
		public String chating(@RequestParam Map map, Model model) {

			int roomNumber = Integer.parseInt((String)map.get("roomNumber"));
			
			
				model.addAttribute("roomName",map.get("roomName"));
				model.addAttribute("roomNumber",map.get("roomNumber"));
			
			
			return "chat";
		}
		

		
}