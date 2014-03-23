<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<BetterWebApp.Models.RegisterModel>" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        
        <h1>Edit Profile:</h1>
    </hgroup>

        <div class="divContainer">
        <fieldset class="registerForm">
            <legend>Edit Profile:</legend>
            <form action="/account/create" method="post">
                

                <div  class="registerForm-li">
                <label for="email" >Edit Email:</label>
                    <span class="textboxAlign">
                <input type="text" name="email" placeholder="Email Address..." /><br />
                    </span>
                </div>

                                       
                <div  class="registerForm-li">
                <label for="password" >Edit Password:</label>
                    <span class="textboxAlign">
                <input type="password" name="password" placeholder="Enter Password..." /><br />
                    </span>
                </div>   
                                   
                <div  class="registerForm-li">
                <label for="confirmpassword">Confirm Password:</label>
                    <span class="textboxAlign">
                <input type="password" name="confirmpassword" placeholder="Confirm Password..." /><br />
                    </span>
                </div>

                <div  class="registerForm-li">
                <label for="parentemail" >Edit Parents Email:</label>
                    <span class="textboxAlign">
                <input type="text" name="parentemail" placeholder="Parents Email Address..." /><br /><p class="statTextHead" title="You must enter a parents email address to be able to get XP points from exercising.">Why?</p><br />
                </span>
                </div>
                

                <div class="centerMaker">
                    <br /><br /><input type="submit" value="Update" />
                </div>
            </form>
        </fieldset>
            </div>
    
    
    

</asp:Content>

<asp:Content ID="Content4" ContentPlaceHolderID="FeaturedContent" runat="server">
    <% if (ViewBag.error) { %>
    <h1>ERROR</h1>
    <p style="text-align: center;"><%: ViewBag.errorMsg %></p>
    <% } %>
</asp:Content>


