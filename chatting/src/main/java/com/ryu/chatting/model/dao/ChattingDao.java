package com.ryu.chatting.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.ryu.chatting.model.Chattinglog;
import com.ryu.chatting.model.Room;
import com.ryu.chatting.model.User;

public interface ChattingDao {
	
	public User login(Map map);
	
	public void register(Map map);
	
	public void createroom(HashMap hashmap);
	
	public void chattinglog(HashMap hashmap);
	
	public List<Room> getroom();
	
	public List<Chattinglog> getmsg(Map map);
	
	public void enrollwait(Map map);
	
	public void deletewait(Map map);
	
	public User searchwait(Map map);
	
	public Room searchrandomroom(Map map);
	
	public void makerandomroom(Map map);
	
	public Integer  getrandomroomnumber(Map map);
	
	public Integer  getrandomroomnumber2(Map map);
	
	public void deleterandomroom(Map map);

}
