<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Battle <%: ViewBag.opponent.name %>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script src="/assets/js/chooseCharacter.js"></script>
<div class="arena">
    <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/characters/<%: ViewBag.cid %>" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>
    <h1 style="text-transform: uppercase;">READY TO BATTLE <%: ViewBag.opponent.name %>?</h1>
    <h2 style="text-align: center;">Choose Your Character</h2>
    <form action="/characters/<%: ViewBag.cid %>/combat/" method="post">
        <% foreach (BetterWebApp.Models.UserCharacter uc in ViewBag.usersCharacters) { %>
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
                <div class="centerMaker" style="padding-right: 20px;">
                    <label for="challenger" style="font-weight: bold;">Choose <%: uc.name %>:</label>
                    <input type="radio" name="challenger" value="<%: uc.id %>" checked/>
                </div>
            </div>
            <div class="clearfix"></div>
        </div>
        <% } %>
        <div class="clearfix"></div>
        <hr />
        <div class="monsterInfo">
            <div class="miLeft">S
                <img src="/images/characters/<%: ViewBag.opponent.imageFileName %>" />
            </div>
            <div class="miRight">
                <div style="margin-bottom: 120px;"></div>
                <h2>You are Battling<br /><%: ViewBag.opponent.name %></h2>
                <div class="" style="margin: auto; width: 65%;">
                    <p><span class="characterHeader">XP:</span> <span class="textboxAlign2"><%: ViewBag.opponent.xp %></span></p>
                    <p><span class="characterHeader">ELEMENT:</span> <span class="textboxAlign2"><%: ViewBag.opponent.fixedCharacter.element.name %></span></p>
                    <p><span class="characterHeader">LEVEL:</span> <span class="textboxAlign2"><%: ViewBag.opponent.level %></span></p>
                    <p><span class="characterHeader">STEP:</span> <span class="textboxAlign2"><%: ViewBag.opponent.step %></span></p>
                    <p><span class="characterHeader">WINS:</span> <span class="textboxAlign2"><%: ViewBag.opponent.wins.Count %></span></p>
                    <p><span class="characterHeader">LOSSES:</span> <span class="textboxAlign2"><%: ViewBag.opponent.losses.Count %></span></p>
                    <p><span class="characterHeader">OWNER:</span> <span class="textboxAlign2"><a href="#"><%: ViewBag.opponent.owner.username %></a></span></p>
                </div>
            </div>
            <div class="clearfix"></div>
            <p>&nbsp;</p>
        </div>
        <!-- I use jQuery to change the value of this hidden element -->
        <input type="submit" class="button" style="border: 0; width: 100% !important; display: block; text-align: center; font-size: 40px; padding: 60px 0;" value="BEGIN BATTLE" />
    </form>
    <div class="centerMaker" style="margin-top: 20px; width: 300px;">
        <a href="/characters/<%: ViewBag.cid %>" class="button">Cancel Battle</a>
    </div>
    <div style="margin-bottom: 60px;"></div>
</div>
</asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="FeaturedContent" runat="server">
</asp:Content>
