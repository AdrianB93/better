<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="contactTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Contact - B.E.T.T.E.R.
</asp:Content>

<asp:Content ID="contactContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1>Contact.</h1>
    </hgroup>
    <div class="divContainer">
        <fieldset class="contactForm">
            <legend>Contact Form</legend>
            <form action="javascript.void(0)" method="post">
                <!-- Label tag -->
                <div class="contactForm-li">
                <input type="text" name="name" value="" placeholder="Name..." /><br />
                </div>
                <div class="contactForm-li">
                <input type="text" name="email" value="" placeholder="Email..." /><br />
                </div>
                <div class="centerMaker-contact contactForm-li">
                <textarea name="message" placeholder="Message..." cols="42" rows="15"></textarea><br />
                </div>
                <div class="centerMaker-contact contactForm-li">
                <input type="submit" name="submit" value="Send Message" />
                </div>
            </form>
        </fieldset>
    </div>
</asp:Content>