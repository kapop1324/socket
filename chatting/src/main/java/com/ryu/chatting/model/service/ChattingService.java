package com.ryu.chatting.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ryu.chatting.model.Chattinglog;
import com.ryu.chatting.model.Room;
import com.ryu.chatting.model.User;

public interface ChattingService {
	
	public User login(Map map);
	
	public void register(Map map);
	
	public void createroom(HashMap hashmap);
	
	public void chattinglog(HashMap hashmap);
	
	public List<Room> getroom();
	
	public List<Chattinglog> getmsg(Map map);

}
