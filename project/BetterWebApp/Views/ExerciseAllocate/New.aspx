<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<dynamic>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
    Allocate Exercise
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

<div class="profileHolder" style="width: 950px; height: 100%;">

    <div class="monsterInfo">
        <div class="miLeft">
            &nbsp;
        </div>
        <div class="miRight">
            <a href="/exercise" id="backtolink"><div class="arrow-left"></div><span>Back</span></a>
        </div>
        <div class="clearfix"></div>
    </div>
        <h1>Allocate Exercise</h1> <h2>XP To Allocate: <span id="xpLeftAmount"><%: ViewBag.user.exerciseXP %></span></h2>
        <% if (ViewBag.usersCharacters.Count == 0) { %>
            <p>You have no characters.</p>
        <% } %>
        <% else { int counter = 0; %>
        
        <form action="/exerciseallocate/create" method="post">
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
                        <label for="xpAllocate<%: counter + 1 %>" style="font-weight: bold;">Allocate:</label>
                        <input type="checkbox" value="<%:uc.id %>" name="checkbx<%: counter + 1 %>" style="display:none;" checked/>
                        <input type="text" name="xpAllocate<%: counter + 1 %>" value="" style="width: 50px;" />
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <% counter++; } %>
            <% while(counter < 4) { %>
            <div style="width: 46% !important; float: left; background: #efefef; border: 10px solid #ffffff; padding: 10px 0;">
                <div style="float: left; width: 49%;">
                    <img src="/images/characters/defaultImage.png" alt="No Monster" title="No Monster" />
                </div>
                <div style="float: left; width: 2%;">&nbsp;</div>
                <div style="float: left; width: 49%;">
                    <h2 style="text-transform: uppercase; font-size: 22px; margin: 0; padding: 0; text-align: center; padding-right: 20px;">No Monster</h2> 
                    <div class="" style="margin: auto; width: 100%; line-height: 14px !important;">
                        <p><span class="characterHeader" style="font-size: 12px;">XP:</span> <span class="textboxAlign2" style="font-size: 12px;">--</span></p>
                        <p><span class="characterHeader" style="font-size: 12px;">ELEMENT:</span> <span class="textboxAlign2" style="font-size: 12px;">--</span></p>
                        <p><span class="characterHeader" style="font-size: 12px;">LEVEL:</span> <span class="textboxAlign2" style="font-size: 12px;">--</span></p>
                        <p><span class="characterHeader" style="font-size: 12px;">STEP:</span> <span class="textboxAlign2" style="font-size: 12px;">--</span></p>
                        <p><span class="characterHeader" style="font-size: 12px;">WINS:</span> <span class="textboxAlign2" style="font-size: 12px;">--</span></p>
                        <p><span class="characterHeader" style="font-size: 12px;">LOSSES:</span> <span class="textboxAlign2" style="font-size: 12px;">--</span></p>
                    </div>
                    <div class="centerMaker" style="height: 55px;">
                    </div>
                </div>
                <div class="clearfix"></div>
            </div>
            <% counter++; } %>
            <div class="centerMaker">
                <input type="submit" value="Allocate" class="button" style="margin-left: 25px; width: 90%; margin-bottom: 60px;" />
            </div>
        </form>
        <% } %>
        <div class="clearfix"></div>
    </div>
</asp:Content>




<asp:Content ID="Content4" ContentPlaceHolderID="FeaturedContent" runat="server">
    <% if (ViewBag.error) { %>
    <h1>ERROR</h1>
    <p style="text-align: center;"><%: ViewBag.errorMsg %></p>
    <% } %>
</asp:Content>
