package com.zmkj.platform.common;

import com.zmkj.platform.service.PhoneCardService;
import com.zmkj.platform.util.CoreFunction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.text.SimpleDateFormat;
import java.util.*;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

/**
 * 定时任务
 */

@Lazy(false)
@Component
public class DataJob {

    @Autowired
    PhoneCardService phoneCardService;

    @Scheduled( fixedDelay = 1800000)
    public void WFyidong(){

        long startDate = System.currentTimeMillis();

        List<Map<String,Object>> allCard = phoneCardService.getAllPhoneCard(1);
        Date currentTime = new Date();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


        if(allCard != null){
            for(Map<String,Object> m : allCard){
                if(m.get("pcid") != null && Integer.parseInt(m.get("pcid").toString()) == 1){
                    List<Map<String,Object>> yd = (List<Map<String, Object>>) m.get("phoneCardList");
                    if(yd.size()>100){
                        List<List<Map<String,Object>>> llst = averageAssign(yd,20);
                        ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
                        for(List<Map<String,Object>> tm : llst){
                            try {
                                WfYdThread myThread = new WfYdThread(tm);
                                myThread.start();

                                cachedThreadPool.execute(new WfYdThread(tm));
                            }catch (Exception e){
                                e.printStackTrace();
                            }
                        }
                        cachedThreadPool.shutdown();
                        while (true){
                            if(cachedThreadPool.isTerminated()){
                                break;
                            }
                        }
                    }else{

                        try {
                            WfYdThread YdThread= new WfYdThread(yd);
                            YdThread.start();
                            YdThread.join();
                        }catch (Exception e){

                        }
                    }
                }
            }
        }
        int ok = (int) (System.currentTimeMillis()-startDate);
        if(ok > 1000){
            System.out.println("WF移动完成扫描 :"+ok);
        }
    }


    //@Scheduled( fixedDelay = 2000)
    public void jianKong(){

        long startDate = System.currentTimeMillis();

        List<Map<String,Object>> allCard = phoneCardService.getAllPhoneCard(3);
        Date currentTime = new Date();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


        if(allCard != null){
            for(Map<String,Object> m : allCard){
                if(m.get("pcid") != null && Integer.parseInt(m.get("pcid").toString()) == 3){
                    List<Map<String,Object>> dx = (List<Map<String, Object>>) m.get("phoneCardList");
                    if(dx.size()>100){
                        List<List<Map<String,Object>>> llst = averageAssign(dx,20);
                        ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
                        for(List<Map<String,Object>> tm : llst){
                            try {
                                /*MyThread myThread = new MyThread(tm);
                                myThread.start();*/
                                cachedThreadPool.execute(new MyThread(tm));
                            }catch (Exception e){
                                e.printStackTrace();
                            }
                        }
                        cachedThreadPool.shutdown();
                        while (true){
                            if(cachedThreadPool.isTerminated()){
                                break;
                            }
                        }
                    }else{

                        try {
                            MyThread myThread = new MyThread(dx);
                            myThread.start();
                            myThread.join();
                        }catch (Exception e){

                        }
                    }

                }
            }
        }
        int ok = (int) (System.currentTimeMillis()-startDate);
        if(ok > 10000){
            System.out.println("电信8万张完成 :"+ok);
        }
    }


    //@Scheduled( fixedDelay = 2000)
    public void JianKongYd(){

        long startDate = System.currentTimeMillis();

        List<Map<String,Object>> allCard = phoneCardService.getAllPhoneCard(4);
        Date currentTime = new Date();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


        if(allCard != null){
            for(Map<String,Object> m : allCard){
                if(m.get("pcid") != null && Integer.parseInt(m.get("pcid").toString()) == 4){
                    List<Map<String,Object>> yd = (List<Map<String, Object>>) m.get("phoneCardList");
                    if(yd.size()>100){
                        List<List<Map<String,Object>>> llst = averageAssign(yd,30);
                        ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
                        for(List<Map<String,Object>> tm : llst){
                            try {
                                /*MyThread myThread = new MyThread(tm);
                                myThread.start();*/

                                cachedThreadPool.execute(new YdThread(tm));
                            }catch (Exception e){
                                e.printStackTrace();
                            }
                        }
                        cachedThreadPool.shutdown();
                        while (true){
                            if(cachedThreadPool.isTerminated()){
                                break;
                            }
                        }
                    }else{

                        try {
                            YdThread YdThread= new YdThread(yd);
                            YdThread.start();
                            YdThread.join();
                        }catch (Exception e){

                        }
                    }
                }
            }
        }
        int ok = (int) (System.currentTimeMillis()-startDate);
        if(ok > 10000){
            System.out.println("移动30万张完成 :"+ok);
        }
    }

    //@Scheduled( fixedDelay = 2000)
    public void JianKongYd2(){

        if(true){
            return;
        }
        long startDate = System.currentTimeMillis();

        List<Map<String,Object>> allCard = phoneCardService.getAllPhoneCard(2);
        Date currentTime = new Date();

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");


        if(allCard != null){
            for(Map<String,Object> m : allCard){
                if(m.get("pcid") != null && Integer.parseInt(m.get("pcid").toString()) == 2){
                    List<Map<String,Object>> yd = (List<Map<String, Object>>) m.get("phoneCardList");
                    if(yd.size()>100){
                        List<List<Map<String,Object>>> llst = averageAssign(yd,30);
                        ExecutorService cachedThreadPool = Executors.newCachedThreadPool();
                        for(List<Map<String,Object>> tm : llst){
                            try {
                                /*MyThread myThread = new MyThread(tm);
                                myThread.start();*/
                                cachedThreadPool.execute(new YdThread2(tm));
                            }catch (Exception e){
                                e.printStackTrace();
                            }
                        }
                        cachedThreadPool.shutdown();
                        while (true){
                            if(cachedThreadPool.isTerminated()){
                                break;
                            }
                        }
                    }else{

                        try {
                            YdThread2 YdThread= new YdThread2(yd);
                            YdThread.start();
                            YdThread.join();
                        }catch (Exception e){

                        }
                    }
                }
            }
        }
        int ok = (int) (System.currentTimeMillis()-startDate);
        if(ok > 10000){
            System.out.println("移动5万张完成 :"+ok);
        }

    }

    //@Scheduled( fixedDelay = (1000 * 60) * 55)
    public void getToken(){

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String t1 = CoreFunction.ydGetToken();
            //String t2 = CoreFunction.ydGetToken2();

            while (t1.equals("")||t1.length() < 2){
                t1 = CoreFunction.ydGetToken();
                System.out.println("重新获取下token");
            }
           /* while (t2.equals("")||t2.length() < 2){
                t2 = CoreFunction.ydGetToken();
                System.out.println("重新获取下token");
            }*/
            TokenLock.setToken(t1);
            //TokenLock.setToken2(t2);
            System.out.println("获取一次token:"+formatter.format(new Date()));
            System.out.println("token为:"+t1);
            //System.out.println("token2为:"+t2);


    }

    /**
     * 每个月的27号晚上23点59开始执行
     */
    //@Scheduled( cron = "0 30 22 27 * ?")
    public void checkData(){
        //停掉所有卡，已充值次月的不停,开次月充值本月没网的卡

        //电信卡

        List<Map<String,Object>> list =   phoneCardService.getAllByPcid(3);
        for(Map<String,Object> map : list){
            if(map.get("cid") != null && map.get("ccid") == null){
                //断网 当用有的 下月没有的
                CoreFunction.dxStop(map.get("msisdn").toString());
                CoreFunction.dxStatusChange(map.get("msisdn").toString(),"19");
                phoneCardService.outData(map.get("iccid").toString());
            }else if(map.get("cid") == null && map.get("ccid") != null){
                //开网 当前没有的 下个月有的
                String status = CoreFunction.dxStatus(map.get("msisdn").toString());
                if(status.equals("5")){
                    //停机状态
                    //恢机 在开网
                    CoreFunction.dxStatusChange(map.get("msisdn").toString(),"20");
                }
                CoreFunction.dxOpen(map.get("msisdn").toString());
                phoneCardService.updateDown(Integer.parseInt(map.get("id").toString()));
            }
            int xianSu = Integer.parseInt(map.get("xiansu").toString());
            if(xianSu == 1){
                phoneCardService.updateXianSu(Integer.parseInt(map.get("id").toString()),0);
            }
        }
    }


    //@Scheduled( cron = "0 0 1 1 * ?")
    public void dxOne(){
        List<Map<String,Object>> list =   phoneCardService.getAllByPcid(3);
        for(Map<String,Object> map : list){
            if(map.get("cid") == null && map.get("ccid") != null){
                //开网 当前没有的 下个月有的
                String status = CoreFunction.dxStatus(map.get("msisdn").toString());
                if(status.equals("5")){
                    //停机状态
                    //恢机 在开网
                    CoreFunction.dxStatusChange(map.get("msisdn").toString(),"20");
                }
                CoreFunction.dxOpen(map.get("msisdn").toString());
                phoneCardService.updateDown(Integer.parseInt(map.get("id").toString()));
            }
            int xianSu = Integer.parseInt(map.get("xiansu").toString());
            if(xianSu == 1){
                phoneCardService.updateXianSu(Integer.parseInt(map.get("id").toString()),0);
            }
        }
    }


    /**
     * 5wanzhangka
     */
    //@Scheduled( cron = "0 20 23 27 * ?")
    public void checkData2(){
        if(true){
            return;
        }
        List<Map<String,Object>> list =   phoneCardService.getAllByPcid(2);
        for(Map<String,Object> map : list){
            if(map.get("cid") != null && map.get("ccid") == null){
                //断网 当用有的 下月没有的
                CoreFunction.ydFunction2(map.get("msisdn").toString(),0);
                phoneCardService.outData(map.get("iccid").toString());
            }else if(map.get("cid") == null && map.get("ccid") != null){
                //开网 当前没有的 下个月有的
                int type = map.get("status") != null?1:2;
                String res = CoreFunction.ydInfo2(map.get("msisdn").toString());
                if(res.equals("库存")){
                    CoreFunction.ydFunction2(map.get("msisdn").toString(),2);
                }else{
                    CoreFunction.ydFunction2(map.get("msisdn").toString(),1);
                }
                phoneCardService.updateDown(Integer.parseInt(map.get("id").toString()));

                if(type == 2){
                    Map<String,Object> updateMap = new HashMap<String,Object>();
                    updateMap.put("id",map.get("id"));
                    updateMap.put("status",1);
                    phoneCardService.update(updateMap);
                }
            }
        }
    }


    //@Scheduled( cron = "0 59 23 28 * ?")
    public void checkData3(){
        if(true){
            return;
        }
        List<Map<String,Object>> list =   phoneCardService.getAllByPcid(4);
        for(Map<String,Object> map : list){
            if(map.get("cid") != null && map.get("ccid") == null){
                //断网 当用有的 下月没有的
                CoreFunction.ydFunction(map.get("msisdn").toString(),0);
                phoneCardService.outData(map.get("iccid").toString());
            }else if(map.get("cid") == null && map.get("ccid") != null){
                //开网 当前没有的 下个月有的

                String res = CoreFunction.ydInfo(map.get("msisdn").toString());
                if(res.equals("库存")){
                    CoreFunction.ydFunction(map.get("msisdn").toString(),2);
                }else{
                    CoreFunction.ydFunction(map.get("msisdn").toString(),1);
                }
                phoneCardService.updateDown(Integer.parseInt(map.get("id").toString()));
                int type = map.get("status") != null?1:2;
                if(type == 2){
                    Map<String,Object> updateMap = new HashMap<String,Object>();
                    updateMap.put("id",map.get("id"));
                    updateMap.put("status",1);
                    phoneCardService.update(updateMap);
                }
            }
        }
    }




    public static <T> List<List<T>> averageAssign(List<T> source, int n){
        List<List<T>> result=new ArrayList<List<T>>();
        //(先计算出余数)
        int remaider=source.size()%n;
        //然后是商
        int number=source.size()/n;
        //偏移量
        int offset=0;
        for(int i=0;i<n;i++){
            List<T> value=null;
            if(remaider>0){
                value=source.subList(i*number+offset, (i+1)*number+offset+1);
                remaider--;
                offset++;
            }else{
                value=source.subList(i*number+offset, (i+1)*number+offset);
            }
            result.add(value);
        }
        return result;
    }



}