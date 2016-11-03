﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/include.inc.jsp"%>
<div class="left-in">
                    <div class="tab-nav">
                        <ul>
                        
                            <li val="0" class="on active"><a>系统指标</a></li>
                            <li val="1" class=""><a>系统能效</a></li>
                            <li val="2" class="last"><a>设备能效</a></li>
                        </ul>
                    </div>
                    
                    <div id="tab1" class="tab-panel" style="display: block;">
                        <c:if test="${not empty energyList_4}">
                        <div class="nyfx-item select-item">
                            <div class="item-tit">
                                <label>
                                    <input type="checkbox" class="selectToggle">指标</label>
                            </div>
                            <div class="item-txt">
                                <c:forEach var="energyList_4" items="${energyList_4}">
									<p>
										<label>
											<input name="classpropertyname" value="${energyList_4.classpropertyid}" type="checkbox" />
											${energyList_4.classpropertyname}
										</label>
									</p>
								</c:forEach>
                            </div>
                        </div>
                        </c:if>
                    </div>
                    <div id="tab2" class="tab-panel" style="display: none;">
                    <c:if test="${not empty energyList_1}">
                        <div class="nyfx-item select-item">
                            <div class="item-tit">
                                <label>
                                    <input type="checkbox" class="selectToggle">耗能</label>
                            </div>
                            <div class="item-txt">
                                <c:forEach var="energyList_1" items="${energyList_1}">
									<p>
										<label>
											<input name="classpropertyname"  value="${energyList_1.classpropertyid}" type="checkbox" />
											${energyList_1.classpropertyname}
										</label>
									</p>
								</c:forEach>
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${not empty energyList_2}">
                        <div class="nyfx-item select-item">
                            <div class="item-tit">
                                <label>
                                    <input type="checkbox" class="selectToggle">供能</label>
                            </div>
                            <div class="item-txt">
                                <c:forEach var="energyList_2" items="${energyList_2}">
									<p>
										<label>
											<input name="classpropertyname" value="${energyList_2.classpropertyid}" type="checkbox" />
											${energyList_2.classpropertyname}
										</label>
									</p>
								</c:forEach>
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${not empty energyList_3}">
                        <div class="nyfx-item select-item">
                            <div class="item-tit">
                                <label>
                                    <input type="checkbox" class="selectToggle">运行效率</label>
                            </div>
                            <div class="item-txt">
                                <c:forEach var="energyList_3" items="${energyList_3}">
									<p>
										<label>
											<input name="classpropertyname" value="${energyList_3.classpropertyid}" type="checkbox" />
											${energyList_3.classpropertyname}
										</label>
									</p>
								</c:forEach>
                            </div>
                        </div>
                        </c:if>
                    </div>
                    <div id="tab3" class="tab-panel" style="display: none;">
                    <c:if test="${not empty energyList_5}">
							<div class="nyfx-item">
								<div class="item-txt" style="margin-left:7px;padding-left: 0;">
									<c:forEach var="energyList_5" items="${energyList_5}">
									<p>
										<label>
											<input name="radioClasspropertyname" value="${energyList_5.classinstanceid}" type="radio" />
											${energyList_5.classinstancename}
										</label>
									</p>
								</c:forEach>
								</div>
							</div>
							</c:if>
                    </div>
                </div>