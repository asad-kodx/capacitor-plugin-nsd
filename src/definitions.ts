import type { PluginListenerHandle } from "@capacitor/core";
export interface DiscoveryParam {
  type: string;
  domain: string;
}

export interface NetService {
  printerCount: number;
  serviceName: string;
  isUntrustedCert: boolean;
  isSearchable: boolean;
  serviceType: number;
  serviceID: string;
  serviceURL: string;
}

export interface NetServiceError {
  code: string;
  error: string;
}
export interface NSDPlugin {
  stopNetworkService(): Promise<void>;
  startFindNewtworkService(params: DiscoveryParam): Promise<void>;
  getAllNetworkService(): Promise<NetService[]>;

  /**
     * Called when a service is resolved and result received.
     *
     * Provides NetService result.
     *
     * @since 0.0.1
     */
  addListener(eventName: "onServiceResolved", listenerFunc: (data: NetService) => void): Promise<PluginListenerHandle> & PluginListenerHandle;

  /**
     * Called when a service discovery is stopped.
     *
     * Provides no result.
     *
     * @since 0.0.1
     */
  addListener(eventName: "onDiscoveryStopped", listenerFunc: (data: any) => void): Promise<PluginListenerHandle> & PluginListenerHandle;

  /**
     * Called on a service error and error received.
     *
     * Provides NetServiceError result.
     *
     * @since 0.0.1
     */
  addListener(eventName: "onServiceError", listenerFunc: (data: NetServiceError) => void): Promise<PluginListenerHandle> & PluginListenerHandle;
}
