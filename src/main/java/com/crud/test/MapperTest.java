package com.crud.test;


import com.crud.bean.Department;
import com.crud.bean.Employee;
import com.crud.dao.DepartmentMapper;
import com.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testInsertOneEmp(){
       employeeMapper.insertSelective(new Employee(null, "n1", "f", "n1@n1", 1));
       employeeMapper.insertSelective(new Employee(null, "n2", "f", "n2@n2", 2));
    }

    @Test
    public void InsertOneDept(){

        departmentMapper.insertSelective(new Department(null,"D3"));
        departmentMapper.insertSelective(new Department(null,"D4"));
    }

    @Test
    public void testInsert1000Emp(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i < 1000; i++) {
            String uuid = UUID.randomUUID().toString().substring(0, 6) + i;
            String sex ="m" ;
            int dept =1;
            if (i%2==0){
                sex= "f";
                dept=2;
            }else {
                sex="m";
            }

            mapper.insertSelective(new Employee(null,uuid,sex,uuid+"@test.com",dept));
        }

        System.out.println("insert finished");
    }

    @Test
    public void TestDeleteOneEmp(){
        employeeMapper.deleteByPrimaryKey(1002);
//        employeeMapper.deleteByPrimaryKey(2);

    }

    @Test
    public void TestDeleteOneDept(){
        departmentMapper.deleteByPrimaryKey(3);
        departmentMapper.deleteByPrimaryKey(4);
    }

    @Test
    public void TestDelete1000Emp(){
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 2; i < 1002; i++) {

            mapper.deleteByPrimaryKey(i);
        }
    }
}
