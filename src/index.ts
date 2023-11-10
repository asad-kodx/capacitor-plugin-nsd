import { registerPlugin } from '@capacitor/core';

import type { NSDPlugin } from './definitions';

const NSD = registerPlugin<NSDPlugin>('NSD', {
  web: () => import('./web').then(m => new m.NSDWeb()),
});

export * from './definitions';
export { NSD };
