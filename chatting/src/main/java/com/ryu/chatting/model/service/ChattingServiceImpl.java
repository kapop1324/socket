package com.ryu.chatting.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ryu.chatting.model.Chattinglog;
import com.ryu.chatting.model.Room;
import com.ryu.chatting.model.User;
import com.ryu.chatting.model.dao.ChattingDao;

@Service
public class ChattingServiceImpl implements ChattingService {
	
	@Autowired
	SqlSession sqlsession;

	@Override
	public User login(Map map) {
		
		return sqlsession.getMapper(ChattingDao.class).login(map);
	}

	@Override
	public void register(Map map) {
		
		sqlsession.getMapper(ChattingDao.class).register(map);
		
	}

	@Override
	public void createroom(HashMap hashmap) {
		
		sqlsession.getMapper(ChattingDao.class).createroom(hashmap);
		
	}

	@Override
	public void chattinglog(HashMap hashmap) {
		
		sqlsession.getMapper(ChattingDao.class).chattinglog(hashmap);;
		
	}

	@Override
	public List<Room> getroom() {
		
		return sqlsession.getMapper(ChattingDao.class).getroom();
		
	}

	@Override
	public List<Chattinglog> getmsg(Map map) {
		
		return sqlsession.getMapper(ChattingDao.class).getmsg(map);
	}

	@Override
	public void enrollwait(Map map) {
		
		sqlsession.getMapper(ChattingDao.class).enrollwait(map);
	
	}

	@Override
	public void deletewait(Map map) {

		sqlsession.getMapper(ChattingDao.class).deletewait(map);
		
	}

	@Override
	public User searchwait(Map map) {
		
		return sqlsession.getMapper(ChattingDao.class).searchwait(map);
	}
}
