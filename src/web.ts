import { WebPlugin } from '@capacitor/core';

import type { NSDPlugin } from './definitions';

export class NSDWeb extends WebPlugin implements NSDPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
