# KeyMaster

KeyMaster is a GitHub authentication gateway inspired by [Gatekeeper](https://github.com/prose/gatekeeper) designed specifically for Chrome Extensions that do not have a specific URL that can be redirected to in order to provide the temporary code that GitHub returns from its OAuth Endpoint. It sends the authorization response string to your Chrome Extension using `chrome.runtime.sendMessage()`.


## Installation

[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)

*More instruction coming soon!*

## Configuration

Configuring your application in GitHub:

- Set the Authorization callback URL to the root URL (eg https://my-heroku-app.herokuapp.com/)

Configuring KeyMaster in Heroku:

- **OAUTH_CLIENT_ID** - The Client ID of your GitHub Application
- **OAUTH_CLIENT_SECRET** - The Client Secret of your GitHub Application
- **CHROME_EXTENSION_ID** - The ID of your Chrome Extension (can be found in `chrome://extensions`)
- **OAUTH_HOST** - Not yet used
- **OAUTH_PORT** - Not yet used
- **OAUTH_PATH** - Not yet used
- **OAUTH_METHOD** - Not yet used

## Usage

In your extension's `manifest.json` file, you'll have to allow messages to be sent by KeyMaster.

```json
"externally_connectable": {
  "matches": ["*://my-heroku-app.herokuapp.com/*"]
}
```

You can send your users to `/authorize` and they'll be redirected to the GitHub authorization page. Once the app redirects back to your instance of KeyMaster, it will post a message to your Chrome Extension which you can receive with:

```javascript
// background.js
chrome.runtime.onMessageExternal.addListener(
  function(request, sender, sendResponse) {
    if(request.message) {
      // request.message is the access_token string from GitHub Auth
    }
  }
);
```

Any query string you send to `/authorize` will be passed on to the GitHub authorization endpoint. So you can set your scope here, eg `?scope=repo,read:org`.

## Roadmap

- Get custom Host, Port, and Path working to support GitHub Enterprise
- Support for messaging methods (to support more than just Chrome Extensions)
- Better error handling
