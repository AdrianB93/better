<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexTitle" ContentPlaceHolderID="TitleContent" runat="server">Home</asp:Content>

<asp:Content ID="indexFeatured" ContentPlaceHolderID="FeaturedContent" runat="server">
<div class="overdivContainer" style="width: 950px; margin: auto;">
    <div class="centerMaker">
        <div class="bigtitle">
            <h1>Hello <%: ViewBag.user.username %>!</h1>
            <h2>Account Information</h2>
            <table class="centerMaker">
                <tr class="display-table-tr">
                    <th class="td-character-1">Username</th>
                    <td class="td-character-1"><%: ViewBag.user.username %></td>
                </tr>
                <tr class="display-table-tr">
                    <th class="td-character-1">Email</th>
                    <td class="td-character-1"><%: ViewBag.user.email %></td>
                </tr>
                <tr class="display-table-tr">
                    <th class="td-character-1">Level</th>
                    <td class="td-character-1"><%: Convert.ToInt32(ViewBag.user.totalXP/1500 + 1) %></td>
                </tr>
                <tr class="display-table-tr">
                    <th class="td-character-1">Total XP</th>
                    <td class="td-character-1"><%: ViewBag.user.totalXP %></td>
                </tr>
                <tr class="display-table-tr">
                    <th class="td-character-1">Exercise Balance</th>
                    <td class="td-character-1"><%: ViewBag.user.exerciseXP %></td>
                </tr>
            </table>
            <span class="statTextHead"><a href="/Account/New"> Update Profile</a></span>
        </div>
        <div class="clearfix"></div>
        
        <h2>Your Characters</h2>
        <% if (ViewBag.characters.Count == 0) { %>
        <p>You have no characters.</p>
        <% } %>
    </div>
    <% foreach (BetterWebApp.Models.UserCharacter uc in ViewBag.characters) { %>
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
                <p><span class="characterHeader" style="font-size: 12px;">LEVEL:</span> <span class="textboxAlign2" style="font-size: 12px;"><%: uc.level %></span></p>
                <p><span class="characterHeader" style="font-size: 12px;">STEP:</span> <span class="textboxAlign2" style="font-size: 12px;"><%: uc.step %></span></p>
                <p><span class="characterHeader" style="font-size: 12px;">WINS:</span> <span class="textboxAlign2" style="font-size: 12px;"><%: uc.wins.Count %></span></p>
                <p><span class="characterHeader" style="font-size: 12px;">LOSSES:</span> <span class="textboxAlign2" style="font-size: 12px;"><%: uc.losses.Count %></span></p>
            </div>
            <a href="/characters/<%: uc.id %>" class="button" style="padding: 20px 0; text-align:center; margin-right: 20px; margin-bottom: 10px;">View</a>
        </div>
        <div class="clearfix"></div>
    </div>
    <% } %>
    <div class="clearfix"></div>
</div>
</asp:Content>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
  
</asp:Content>
