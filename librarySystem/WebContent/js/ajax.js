function StringBuilder()

{

    this._content = new Array();

    if( typeof StringBuilder._init  == "undefined" )

    {

        StringBuilder.prototype.Append  = function(str)

        {

            this._content.push( str );

        }

        StringBuilder.prototype.ToString = function()

        {

            return this._content.join("");

        }

        StringBuilder._init = true;

    }

}

function Ajax()

{

    this._xmlHttp = (function()

                    {

                        try

                        {

                            if( window.ActiveXObject )

                            {

                                var arrSignature = ["MSXML2.XMLHTTP.5.0","MSXML2.XMLHTTP.4.0","MSXML2.XMLHTTP.3.0",

                                                    "MSXML2.XMLHTTP.2.0","Microsoft.XMLHTTP"];

                                for( var i = 0; i < arrSignature.length; i++ )

                                {

                                    try{

                                            return  new ActiveXObject(arrSignature[i]);

                                       }

                                    catch( exception )

                                    {

                                    }

                                }

                            }

                            else

                            {

                                return new XMLHttpRequest();

                            }

                        }

                        catch(exception)

                        {

                            throw new Error("Your browser doesn't support XMLHttpRequest object!");

                        }

                    })();

     this._params = new StringBuilder();

     if( typeof Ajax._init == "undefined")

     {

        Ajax.prototype.Get = function(url, oFunction)

        {

            var oXMLHttp = this._xmlHttp;

            this._xmlHttp.open("get",url+this.GetParams(),true);

            this._xmlHttp.onreadystatechange = function()

                                                        { 

                                                            if( oXMLHttp.readyState == 4 )

                                                            oFunction(oXMLHttp.responseText,oXMLHttp.responseXml);

                                                        };

            this._xmlHttp.setRequestHeader("Cache-Control","no-cache"); 

            this._xmlHttp.send(null);

        }

        Ajax.prototype.Post = function(url, oFunction)

        {

            var oXMLHttp = this._xmlHttp;

            this._xmlHttp.open("post",url,true);

            this._xmlHttp.onreadystatechange = function()

                                                        {

                                                            if(oXMLHttp.readyState==4 )

                                                                oFunction(oXMLHttp.responseText,oXMLHttp.responseXml);

                                                        }

            this._xmlHttp.setRequestHeader("Cache-Control","no-cache");                                             

            this._xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded");

            this._xmlHttp.send(this.GetParams().substring(1));

        }

        Ajax.prototype.AddParams = function( name, value )

        {   if( this._params.ToString().indexOf("?")== -1 )

            {

                this._params.Append("?");

            }

            else

            {

                this._params.Append("&");

            }

            this._params.Append( encodeURIComponent(name) );

            this._params.Append( "=" );

            this._params.Append( encodeURIComponent(value));

        }

        Ajax.prototype.GetParams = function()

        {

            return this._params.ToString() +"&rand="+ Math.random();

        }

        Ajax._init = true;

     }

}

/* 调用
var ajax=new Ajax();

ajax.AddParams("Name","CharlesChen");

ajax.AddParams("Sex","男");

ajax.Post("test.jsp",function()

{

    HandlesMethod(arguments[0],arguments[1])

});
*/