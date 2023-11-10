import { WebPlugin } from '@capacitor/core';

import type { DiscoveryParam, NetService, NSDPlugin } from './definitions';

export class NSDWeb extends WebPlugin implements NSDPlugin {
  stopNetworkService(): Promise<void> {
    throw new Error('Method not implemented.');
  }
  startFindNewtworkService(params: DiscoveryParam): Promise<void> {
    throw new Error('Method not implemented.'+params);
  }
  getAllNetworkService(): Promise<NetService[]> {
    throw new Error('Method not implemented.');
  }
}
