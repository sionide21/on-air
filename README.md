# On Air Sign

A wifi controllable "On Air" sign.

### Wifi Setup

Connect to a laptop over USB and ssh to `nerves.local`.

From a shell, run the following command to set up wifi. It will persist across reboots.

```
VintageNet.configure("wlan0", %{
  type: VintageNetWiFi,
  vintage_net_wifi: %{
    networks: [
      %{
        key_mgmt: :wpa_psk,
        psk: "<wifi password>",
        ssid: "<wifi ssid>"
      }
    ]
  },
  ipv4: %{method: :dhcp}
})
```
