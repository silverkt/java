﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
    <div class="tab-nav">
        <ul class="ml10">
            <li class="last"><a class="spec">已选运行参数</a></li>
        </ul>
    </div>
    <div class="tab-panel" style="display: block;">
       <div class="select-list">
        </div>
        <p class="tcenter yred mt5 error"></p>
        <div class="select-contit">
        <div class="mod-select  mt5" id="selectSb">
            <p class="text">选择设备</p>
            <span class="arr-group hand">
                <i class="icon-mod icon-arr"></i>
            </span>
            <div class="list">
                <ul>
	                <c:forEach var="shebei" items="${shebeiList}">
	               		 <li val="${shebei.classinstanceid }"><a href="">${shebei.classinstancename }</a></li>
	                </c:forEach>
                </ul>
            </div>
        </div>
        <div class="mod-select mt5" id="selectCs">
            <p class="text">选择参数</p>
            <span class="arr-group hand">
                <i class="icon-mod icon-arr"></i>
            </span>
            <div class="list">
                <ul>
                </ul>
            </div>
        </div>
            </div>
        <a class="confirm mauto mt15 dblock" id="confirm">确认</a>
    </div>
