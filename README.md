# capacitor-plugin-nsd

capacitor plugin nsd

## Install

```bash
npm install capacitor-plugin-nsd
npx cap sync
```

## API

<docgen-index>

* [`stopNetworkService()`](#stopnetworkservice)
* [`startFindNewtworkService(...)`](#startfindnewtworkservice)
* [`getAllNetworkService()`](#getallnetworkservice)
* [`addListener('onServiceResolved', ...)`](#addlisteneronserviceresolved)
* [`addListener('onServiceRemoved', ...)`](#addlisteneronserviceremoved)
* [`addListener('onDiscoveryStopped', ...)`](#addlistenerondiscoverystopped)
* [`addListener('onServiceError', ...)`](#addlisteneronserviceerror)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### stopNetworkService()

```typescript
stopNetworkService() => Promise<void>
```

--------------------


### startFindNewtworkService(...)

```typescript
startFindNewtworkService(params: DiscoveryParam) => Promise<void>
```

| Param        | Type                                                      |
| ------------ | --------------------------------------------------------- |
| **`params`** | <code><a href="#discoveryparam">DiscoveryParam</a></code> |

--------------------


### getAllNetworkService()

```typescript
getAllNetworkService() => Promise<NetService[]>
```

**Returns:** <code>Promise&lt;NetService[]&gt;</code>

--------------------


### addListener('onServiceResolved', ...)

```typescript
addListener(eventName: "onServiceResolved", listenerFunc: (data: NetService) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

Called when a service is resolved and result received.

Provides <a href="#netservice">NetService</a> result.

| Param              | Type                                                                 |
| ------------------ | -------------------------------------------------------------------- |
| **`eventName`**    | <code>'onServiceResolved'</code>                                     |
| **`listenerFunc`** | <code>(data: <a href="#netservice">NetService</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

**Since:** 0.0.1

--------------------


### addListener('onServiceRemoved', ...)

```typescript
addListener(eventName: "onServiceRemoved", listenerFunc: (data: NetService) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

Called when a service is removed and result received.

Provides <a href="#netservice">NetService</a> result.

| Param              | Type                                                                 |
| ------------------ | -------------------------------------------------------------------- |
| **`eventName`**    | <code>'onServiceRemoved'</code>                                      |
| **`listenerFunc`** | <code>(data: <a href="#netservice">NetService</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

**Since:** 0.0.1

--------------------


### addListener('onDiscoveryStopped', ...)

```typescript
addListener(eventName: "onDiscoveryStopped", listenerFunc: (data: any) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

Called when a service discovery is stopped.

Provides no result.

| Param              | Type                                |
| ------------------ | ----------------------------------- |
| **`eventName`**    | <code>'onDiscoveryStopped'</code>   |
| **`listenerFunc`** | <code>(data: any) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

**Since:** 0.0.1

--------------------


### addListener('onServiceError', ...)

```typescript
addListener(eventName: "onServiceError", listenerFunc: (data: NetServiceError) => void) => Promise<PluginListenerHandle> & PluginListenerHandle
```

Called on a service error and error received.

Provides <a href="#netserviceerror">NetServiceError</a> result.

| Param              | Type                                                                           |
| ------------------ | ------------------------------------------------------------------------------ |
| **`eventName`**    | <code>'onServiceError'</code>                                                  |
| **`listenerFunc`** | <code>(data: <a href="#netserviceerror">NetServiceError</a>) =&gt; void</code> |

**Returns:** <code>Promise&lt;<a href="#pluginlistenerhandle">PluginListenerHandle</a>&gt; & <a href="#pluginlistenerhandle">PluginListenerHandle</a></code>

**Since:** 0.0.1

--------------------


### Interfaces


#### DiscoveryParam

| Prop         | Type                |
| ------------ | ------------------- |
| **`type`**   | <code>string</code> |
| **`domain`** | <code>string</code> |


#### NetService

| Prop                  | Type                 |
| --------------------- | -------------------- |
| **`printerCount`**    | <code>number</code>  |
| **`serviceName`**     | <code>string</code>  |
| **`isUntrustedCert`** | <code>boolean</code> |
| **`isSearchable`**    | <code>boolean</code> |
| **`serviceType`**     | <code>number</code>  |
| **`serviceID`**       | <code>string</code>  |
| **`serviceURL`**      | <code>string</code>  |


#### PluginListenerHandle

| Prop         | Type                                      |
| ------------ | ----------------------------------------- |
| **`remove`** | <code>() =&gt; Promise&lt;void&gt;</code> |


#### NetServiceError

| Prop        | Type                |
| ----------- | ------------------- |
| **`code`**  | <code>string</code> |
| **`error`** | <code>string</code> |

</docgen-api>
