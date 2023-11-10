export interface NSDPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
