<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Index
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<h1 style="">YOUR HALL OF FAME CHARACTERS</h1>
<% if (ViewBag.hofCharacters.Count == 0) { %>
    <p style="text-align: center;">You don't have any characters in the hall of fame.</p>
<% } %>
<% foreach (BetterWebApp.Models.UserCharacter uc in ViewBag.hofCharacters) { %>
<div style="width: 46% !important; float: left; background: #efefef; border: 10px solid #ffffff; padding: 10px 0;">
    <div style="float: left; width: 49%;">
        <img src="/images/characters/<%: uc.imageFileName %>" alt="<%: uc.name %>" title="<%: uc.name %>" />
    </div>
    <div style="float: left; width: 2%;">&nbsp;</div>
    <div style="float: left; width: 49%;">
        <h2 style="text-transform: uppercase; font-size: 22px; margin: 0; padding: 0; text-align: center; padding-right: 20px;"><%: uc.name %></h2> 
        <div class="" style="margin: auto; width: 100%; line-height: 14px !important;">
            <p><span class="characterHeader" style="font-size: 12px;">XP:</span> <span class="textboxAlign2" style="font-size: 12px;"><%: uc.xp %></span></p>
            <p><span class="characterHeader" style="font-size: 12px;">ELEMENT:</span> <span class="textboxAlign2" style="font-size: 12px;"><%: uc.fixedCharacter.element.name %></span></p>
            <p><span class="characterHeader" style="font-size: 12px;">LEVEL:</span> <span class="textboxAlign2" style="font-size: 12px;">4</span></p>
            <p><span class="characterHeader" style="font-size: 12px;">STEP:</span> <span class="textboxAlign2" style="font-size: 12px;">4</span></p>
            <p><span class="characterHeader" style="font-size: 12px;">WINS:</span> <span class="textboxAlign2" style="font-size: 12px;"><%: uc.wins.Count %></span></p>
            <p><span class="characterHeader" style="font-size: 12px;">LOSSES:</span> <span class="textboxAlign2" style="font-size: 12px;"><%: uc.losses.Count %></span></p>
        </div>
    </div>
    <div class="clearfix"></div>
</div>
<% } %>

</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
