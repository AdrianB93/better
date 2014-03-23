<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Hall of Fame
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
<h1>Hall Of Fame</h1>
    <div class="centerMaker createNewButton" style="width: 55%; margin-top: 0px;">
        <p><a href="/characters" class="newCharbutton"><span>View Playing Characters</span></a></p>
    </div>

    <div class="tableHolder">
    <table class="centerMaker">
        <tr>
            <th>Name</th>
            <th>View</th>
        </tr>
      
        
        <% foreach (BetterWebApp.Models.UserCharacter uc in ViewBag.hallOfFameUsers)
           { %>
                <tr class="display-table-tr">
                <td class="td-character-1"><%: uc.name %></td>
                <td class="td-character-3"><a href="/characters/<%: uc.id %>">View Monster</a></td>
                </tr>
        <% } %>
    </table>
        </div>

</asp:Content>



<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
