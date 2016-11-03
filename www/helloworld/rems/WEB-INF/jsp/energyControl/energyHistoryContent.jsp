﻿<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ include file="/include.inc.jsp"%>
                    <div class="datalist-div">
                    <input type="hidden" id="countPageId" value="${countPage }">
                        <table class="datalist newdatalist">
                            <thead>
                                <tr>
                                    <td>时间</td>
                                    <c:forEach var="ltr" items="${listTrTemp}">
                                    	<td>${ltr.classinstancename }<p class="">${ltr.classpropertyname }(${ltr.unitname })</sup></p>
                                    </c:forEach>
                               </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="dt" items="${historyContentList}" varStatus="s">
								<tr class="${s.index%2 eq 0 ? 'even' : 'odd'}">
										<c:choose> 
                                    		<c:when test="${timeradio eq 'mons'}">
                                    			 <td>${fn:substring(dt.data1,0,7)}</td>
                                    		</c:when>
                                    		<c:when test="${timeradio eq 'days'}">
                                    			<td>${fn:substring(dt.data1,0,10)}</td> 
                                    		</c:when>
                                    		<c:otherwise>
                                    			 <td>${dt.data1 }</td>
                                    		</c:otherwise>
                                    	</c:choose>
									
				                     <c:if test="${not empty listTrTemp[0] }">
					                     <td>
						                     <c:choose>
												<c:when test="${dt.data2 == '-99999' }" >-</c:when>
												<c:otherwise><fmt:formatNumber value="${dt.data2}" pattern=",###.##" /></c:otherwise>
											</c:choose>
					                     </td>
				                     </c:if>
				                     <c:if test="${not empty listTrTemp[1] }">
					                     <td>
					                     <c:choose>
											<c:when test="${dt.data3 == '-99999' }" >-</c:when>
											<c:otherwise><fmt:formatNumber value="${dt.data3}" pattern=",###.##" /></c:otherwise>
										</c:choose>
					                     </td>
				                     </c:if>
				                     <c:if test="${not empty listTrTemp[2] }">
					                     <td>
					                     	<c:choose>
												<c:when test="${dt.data4 == '-99999' }" >-</c:when>
												<c:otherwise><fmt:formatNumber value="${dt.data4}" pattern=",###.##" /></c:otherwise>
											</c:choose>
					                     </td>
				                     </c:if>
				                </tr>
							</c:forEach>
                            </tbody>
                        </table>
                    </div>
