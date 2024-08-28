```qml
import QtWebSockets
    WebSocket {
        id: wsocket
        url: "ws://124.222.224.186:8800"
        onTextMessageReceived: function(message) {
            console.log("\nReceived message: !!!!!!!!!!!!!!!!!!!!" + message)
        }
        onStatusChanged: {
            if (socket.status == WebSocket.Error) {
                console.log("!!!!!!!!!!!!!!!!!!!!!!Error: " + socket.errorString)
            } else if (socket.status == WebSocket.Open) {
                socket.sendTextMessage("Hello World!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            } else if (socket.status == WebSocket.Closed) {
                "\nSocket closed!!!!!!!!!!!!!!!!!!!!!!!!!!!"
            }
        }
        active: true
    }
```