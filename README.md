# foursquare-pi

Simple NodeJS experiment controlling one of RaspberryPIs GPIO pins and producing an audio greeting triggered by Foursquares Venue-Push-API.

## Disclaimer

As stated above this is just a simple and fast experiment. Most of the packages used were just chosen because they showed up on top of some google searches, did seem to make sense and worked on the first try ;)

Future releases may change the requirements or dependencies, if a better option was discovered.

## Requirements

* [RaspberryPI](http://www.raspberrypi.org/ "RaspberryPI") accessible from the internet.
* [NodeJS](https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#debian-lmde) on the RaspberryPI
* [gpio-admin](https://github.com/quick2wire/quick2wire-gpio-admin "Github: quick2wire/quick2wire-gpio-admin") on the RaspberryPI
* SSL-Certificate (may be [self-signed](http://www.akadia.com/services/ssh_test_certificate.html "Self-Signed-SSL-Certificate"))
* [Foursquare-App](https://developer.foursquare.com/ "Foursquare Developer") with [Venue-Push-API](https://developer.foursquare.com/overview/realtime "Foursquare Real-Time API") enabled
* Foursquare Account which is the manager of at least one Foursquare-Venue
* [eSpeak](http://espeak.sourceforge.net/ "eSpeak - Text to speech  synthesizer") on the RaspberryPI
<pre><code class="sh">$ sudo apt-get install espeak</code></pre>

## Clone the repository

<pre><code class="sh">$ git clone https://github.com/DieProduktMacher/foursquare-pi.git</code></pre>

## Configure

Copy the config.json.example and edit the placeholders so that it fits your needs.
<pre><code class="sh">$ cd foursquare-pi
$ cp config.json.example config.json
$ vi config.json
</code></pre>

## Install nodejs modules

<pre><code class="sh">$ npm install -g coffee-script
$ npm install
</code></pre>

## Start application

<pre><code class="sh">$ coffee app.coffee</code></pre>

If you have left the passphrase on the SSL private key, you will be prompted to enter it now. If everything is configured correctly the app should be responding to HTTPS-Requests at port 8888 with a some simple text.

If you want to keep it running in the background, use any mechanism that seems feasible to you. (I'm just using a screen session right now.)

## Configure Network

Make sure your RaspberryPI can be always be accessed from the internet. This might mean to configure your router to port-forward for example port 443 to port 8888 on the (static) ip-address of your RaspberryPI and perhaps use some dynamic dns service to always map a domain name to your external dynamically assigned ip-address.

## Foursquare app configuration

Now you should make sure that the settings of your Foursquare app are matching your needs.
* You may use
<pre>https://ip-address-and-port-or-domain-name-for-your-raspberrypi</pre>
as download, welcome and privacy page, since no real user will ever have to get to that.
* For the same reason you want to keep the app in the sandboxed developer mode.
* You need to set
<pre>https://ip-address-and-port-or-domain-name-for-your-raspberrypi/foursqare/callback</pre>
as the redirect URI
* You need to set
<pre>https://ip-address-and-port-or-domain-name-for-your-raspberrypi/foursquare/checkin</pre>
as the URL for the Push-API.

## Connect to Foursquare

Open a browser and enter the following URL:

<pre>https://ip-address-and-port-or-domain-name-for-your-raspberrypi/foursquare/connect</pre>

You will be prompted by Foursquare to authorize this app. Do so with an account which is a manager of the venue you'd like to receive real-time pushes for.

You will be redirected to the simple text page of the app

## Make it happen in the real world

To see if the GPIO trigger is working you may want to connect a LED (with an appropriate resistor) to the GPIO-Pin you have configured.

To hear the greeting plug some speakers or earphones into the audio jack of the RaspberryPI.

## Checkin

Now you can checkin to your venue and the LED should immediately  light up for 5 seconds while you hear a friendly voice greeting you with "Welcome to the party, YOUR_FIRST_NAME.".
**Note:** Male users will be greeted by a female voice and vice versa.

## Use your own imagination

Now your able to trigger something in the real world when somebody uses Foursquare to checkin to your venue. You may do really crazy things with it. I'm really looking forward to what you come up with.

[Here is a small video](http://youtu.be/ZtS7Yx_XI0c "Demo of the Party-Greeting-Machine") of our own Party-Greeting-Machine to give you some inspiration.

## Just a few ideas for possible features

* configurable length of GPIO high
* configurable and randomizable audio greeting text
* configurable voices
* configurable special greetings for special users (i.e. mayor or using your bosses user-ids)
* trigger for more than one GPIO pin(?)
* daemonizable startup
* use a display via HDMI...
* ...ideas welcome

## Improvements

Suggestions are always welcome :)

## License

The MIT License (MIT)

Copyright (c) 2013 [Thomas Limp](mailto:thomas.limp@produktmacher.com), [DieProduktMacher GmbH](http://www.dieproduktmacher.com "DieProduktMacher GmbH")

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## The end

...and may the source be with you.
