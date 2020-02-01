package com.zmkj.platform.controller;

import com.zmkj.platform.entity.Agents;
import com.zmkj.platform.entity.Pclass;
import com.zmkj.platform.service.AgentsService;
import com.zmkj.platform.service.PclassService;
import com.zmkj.platform.service.PhoneCardService;
import com.zmkj.platform.util.WFyidong;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminControllerTwo {

    @Autowired
    HttpServletRequest request;

    @Autowired
    PclassService pclassService;

    @Autowired
    PhoneCardService phoneCardService;

    @Autowired
    AgentsService agentsService;

    /**
     * 卡片列表
     * @return
     */
    @RequestMapping("/cardList")
    public String cardList(){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        List<Pclass> pclassList =  pclassService.getPclass(null,null);
        request.setAttribute("pclassList",pclassList);
        return "admin_card_list";
    }


    //获取卡片列表的数据
    @RequestMapping("/getCardListData")
    @ResponseBody
    public String getCardListData(Integer pcid,Integer limit,Integer offset,String search){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            return "no-data";
        }
        return phoneCardService.getCardListData(agent.getId(),limit,offset,search);
    }

    /**
     * 批量划分卡
     * @param start
     * @param end
     * @return
     */
    @GetMapping("/changeCard")
    @ResponseBody
    public String createNumber(String aid,long start,long end){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            return "error";
        }
        if(end - start > 2000 || start > end){
            return "一次分配不能大于两千，开始卡号也不能比结束卡号大";
        }
        Agents agents = agentsService.getAgentsByAccount(aid);
        if(agents == null){
            return "该账户"+aid+"不存在";
        }
        if(! agents.getParentId().equals(agent.getId())){
            return "失败";
        }
        int[] result = phoneCardService.updateCard(agents.getId() ,start,end,agent.getId());

        return "成功:"+result[0]+"条,失败："+result[1]+"条";
    }

    @GetMapping("/changCardOne")
    @ResponseBody
    public String changCardOne(String aid,String iccid){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            return "error";
        }
        Agents agents = agentsService.getAgentsByAccount(aid);
        if(agents == null){
            return "该账户"+aid+"不存在";
        }
        if(! agents.getParentId().equals(agent.getId())){
            return "失败";
        }
        int r = phoneCardService.updateCardOne(agents.getId(),iccid,agent.getId());
        if(r > 0){
            return "成功";
        }else {
            return "失败";
        }
    }

    @GetMapping("/hf")
    public String hf(){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            request.setAttribute("login_title","请先登录");
            return "login";
        }
        return "admin_huafen";
    }

    @GetMapping("/cardUpdate")
    @ResponseBody
    public int cardUpdate(String iccid,Integer type){
        Agents agent = (Agents)request.getSession().getAttribute("user_agent");
        if(agent == null){
            return 250;//二百五
        }
        Map<String,Object> phoneCard = phoneCardService.getPhoneCardByIccid(iccid);
        if(phoneCard != null){
            if(agent.getId().equals(Integer.parseInt(phoneCard.get("aid").toString())) || agent.getParentId().equals(0)){
                if(type.equals(0)){
                    if(WFyidong.end(iccid)){

                        return 1;
                    }
                }else{
                    if(WFyidong.start(iccid)){
                        return 1;
                    }
                }
            }
        }
        return 250;
    }
}
