package com.oti.srm.service;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oti.srm.dao.IDistributeDao;

@Service
public class DistributeService implements IDistributeService{
	@Autowired
	IDistributeDao distributeDao;
}
