#import <Foundation/Foundation.h>
#import <Capacitor/Capacitor.h>

// Define the plugin using the CAP_PLUGIN Macro, and
// each method the plugin supports using the CAP_PLUGIN_METHOD macro.
CAP_PLUGIN(NSDPlugin, "NSD",
           CAP_PLUGIN_METHOD(startFindNewtworkService, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(stopNetworkService, CAPPluginReturnPromise);
           CAP_PLUGIN_METHOD(getAllNetworkService, CAPPluginReturnPromise);
)
