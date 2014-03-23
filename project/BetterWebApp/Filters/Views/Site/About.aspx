<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="aboutTitle" ContentPlaceHolderID="TitleContent" runat="server">
    About - B.E.T.T.E.R.
</asp:Content>

<asp:Content ID="aboutContent" ContentPlaceHolderID="MainContent" runat="server">
    <hgroup class="title">
        <h1>About</h1>

    </hgroup>

    <article>
        <div class="aboutHeading">
            <h2>About NewU</h2>
            <p>
            NewU is a group of professional students.
            </p>
        </div>
        <div class="aboutHeading">
            <h2>About the Team</h2>
            <p>
            <img src="/images/aboutpics/alex.jpg" style="border-radius:200px;"/>
            </p>
            <p>
                Alex Ketley is our JQuery and design guy.
            </p>
            <p>
            <img src="/images/aboutpics/ashley.jpg" style="border-radius:200px;"/>
            </p>
            <p>
                Ashley Coleman is our programmer / designer.
            </p>
        </div>
        <div class="aboutHeading">
            <p>
            <img src="/images/aboutpics/adrian.jpg" style="border-radius:200px;"/>
            </p>
            <p>
                Adrian Brown is our programmer / designer / aspiring web developer.
            </p>
        </div>

    </article>
</asp:Content>