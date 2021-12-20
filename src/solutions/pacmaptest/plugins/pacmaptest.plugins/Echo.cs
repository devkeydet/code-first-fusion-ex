using Microsoft.Xrm.Sdk;
using System;

namespace pacmaptest.plugins
{
    /* 
     * Plugin development guide: https://docs.microsoft.com/powerapps/developer/common-data-service/plug-ins
     * Best practices and guidance: https://docs.microsoft.com/powerapps/developer/common-data-service/best-practices/business-logic/
     */
    public class Echo : PluginBase
    {
        public Echo(string unsecureConfiguration, string secureConfiguration)
            : base(typeof(Echo))
        {
            // TODO: Implement your custom configuration handling
            // https://docs.microsoft.com/powerapps/developer/common-data-service/register-plug-in#set-configuration-data
        }

        // Entry point for custom business logic execution
        protected override void ExecuteCdsPlugin(ILocalPluginContext localPluginContext)
        {
            if (localPluginContext == null)
            {
                throw new ArgumentNullException(nameof(localPluginContext));
            }

            var context = localPluginContext.PluginExecutionContext;

            string echoMe = (string)context.InputParameters["EchoMe"];
            context.OutputParameters["EcoOutput"] = $"{echoMe}-updated";
        }
    }
}
