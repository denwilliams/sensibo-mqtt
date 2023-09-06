# sesnsibo-mqtt

Publish status/state of Sensibo devices, and allow setting state over MQTT.

## Installation and Configuration

It is intended to be installed globally, ie `npm i -g sensibo-mqtt`

Create a YAML file somewhere. See `config.example.yml`

Run (replace path)

```
CONFIG_PATH=/path/to/my/config.yml sensibo-mqtt
```

You can also use Consul for config. See [mqtt-usvc](https://www.npmjs.com/package/mqtt-usvc) for more details.

You need to provide and `apiKey` in the config. The `pollInterval` is optional (default 60000 [60s]).

## Status Updates

Once started you will receive status updates on `sensibo/status/{device_id}` at the configured `pollInterval`. The event will be emitted regardless of whether anything has changed.

## Controlling

You can change AC state sending to `sensibo/set/{device_id}/acState` [see post details](https://sensibo.github.io/#/paths/~1pods~1{device_id}~1acStates/post), or just single properties using `sensibo/set/{device_id}/acState/{property}` [see patch details](https://sensibo.github.io/#/paths/~1pods~1{device_id}~1acStates~1{property}/patch) or enable climate react using `sensibo/set/{device_id}/smartmode`
[see put details](https://sensibo.github.io/#/paths/~1pods~1{device_id}~1smartmode/put) _NOTE: seems this endpoint doesn't work on the Sensibo API._

Eg, send to:

- topic = `sensibo/set/Abcd123/acState/on`
- value = `true`

or

- topic = `sensibo/set/Abcd123/smartmode`
- value = `true`

or

- topic = `sensibo/set/Abcd123/acState`
- value = `{"on"true,"mode":"cool","fanLevel":"auto","targetTemperature":22}`

## HTTP Status

To enable set a http port in the config (see example), then poll /status on that port.

## Docker

To run this as a standalone docker
```
docker build -t sensibo-mqtt .
docker run -d --name sensibo-mqtt -v /wherever/your/config.yml:/app/config.yml sensibo-mqtt 
```
