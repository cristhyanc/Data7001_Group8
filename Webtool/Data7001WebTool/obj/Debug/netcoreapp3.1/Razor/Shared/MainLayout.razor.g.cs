#pragma checksum "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\Shared\MainLayout.razor" "{ff1816ec-aa5e-4d10-87f7-6f4963833460}" "a540986250aa81aa0d44d80b21a28802ad97af2d"
// <auto-generated/>
#pragma warning disable 1591
namespace Data7001WebTool.Shared
{
    #line hidden
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Components;
#nullable restore
#line 1 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using System.Net.Http;

#line default
#line hidden
#nullable disable
#nullable restore
#line 2 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Microsoft.AspNetCore.Authorization;

#line default
#line hidden
#nullable disable
#nullable restore
#line 3 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Microsoft.AspNetCore.Components.Authorization;

#line default
#line hidden
#nullable disable
#nullable restore
#line 4 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Microsoft.AspNetCore.Components.Forms;

#line default
#line hidden
#nullable disable
#nullable restore
#line 5 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Microsoft.AspNetCore.Components.Routing;

#line default
#line hidden
#nullable disable
#nullable restore
#line 6 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Microsoft.AspNetCore.Components.Web;

#line default
#line hidden
#nullable disable
#nullable restore
#line 7 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Microsoft.JSInterop;

#line default
#line hidden
#nullable disable
#nullable restore
#line 8 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Data7001WebTool;

#line default
#line hidden
#nullable disable
#nullable restore
#line 9 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Data7001WebTool.Shared;

#line default
#line hidden
#nullable disable
#nullable restore
#line 10 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Syncfusion.Blazor;

#line default
#line hidden
#nullable disable
#nullable restore
#line 11 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\_Imports.razor"
using Syncfusion.Blazor.Calendars;

#line default
#line hidden
#nullable disable
    public partial class MainLayout : LayoutComponentBase
    {
        #pragma warning disable 1998
        protected override void BuildRenderTree(Microsoft.AspNetCore.Components.Rendering.RenderTreeBuilder __builder)
        {
            __builder.OpenElement(0, "div");
            __builder.AddAttribute(1, "class", "sidebar");
            __builder.OpenComponent<Data7001WebTool.Shared.NavMenu>(2);
            __builder.CloseComponent();
            __builder.CloseElement();
            __builder.AddMarkupContent(3, "\r\n\r\n");
            __builder.OpenElement(4, "div");
            __builder.AddAttribute(5, "class", "main");
            __builder.AddMarkupContent(6, "<div class=\"top-row px-4\"><a href=\"https://docs.microsoft.com/aspnet/\" target=\"_blank\">About</a></div>\r\n\r\n    ");
            __builder.OpenElement(7, "div");
            __builder.AddAttribute(8, "class", "content px-4");
            __builder.AddContent(9, 
#nullable restore
#line 13 "D:\Users\crist\Documents\GitHub\Data7001_Group8\Webtool\Data7001WebTool\Shared\MainLayout.razor"
         Body

#line default
#line hidden
#nullable disable
            );
            __builder.CloseElement();
            __builder.CloseElement();
        }
        #pragma warning restore 1998
    }
}
#pragma warning restore 1591
