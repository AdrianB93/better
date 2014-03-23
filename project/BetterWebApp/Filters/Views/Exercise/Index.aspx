<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>
<h1>Exercise:</h1>
     
    
    <div class="centerMaker createNewButton" style="width: 55%; margin-top: 20px;">
        <p><a href="/exercise/new" class="newCharbutton"><span>Add Exercise</span></a></p>
    </div>
    <div class="centerMaker createNewButton" style="width: 55%; margin-top: 0px;">
        <p><a href="/exerciseallocate/new" class="newCharbutton"><span>Allocate</span></a></p>
    </div>

    
    
    <div class="tableHolder">
    <table class="centerMaker">
        <tr>
            <th>Date</th>
            <th>Shakes</th>
            <th>Valid?</th>
        </tr>

         <% foreach (BetterWebApp.Models.Exercise e in ViewBag.exercises)
            { %>
        <tr class="display-table-tr">
            <td class="td-character-5"><%: e.date %></td>
            <td class="td-character-3"><%: e.shakes %></td>
            <td class="td-character-2"><% if(e.isValid) { %>Yes<% } else { %>No <a href="/exercise/<%: e.id %>/edit">(Click Here)</a><% } %></td>
        </tr>
        <% } %>
      
    </table>
        </div>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
