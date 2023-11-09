import QtQuick 2.0

Item {
  id: control
  width: 40
  height: 40

  property variant color: [0, 0.7, 0.67]

  function requestPaint() {
    bookBackCover.requestPaint()
    bookFrontCover.requestPaint()
  }

  Canvas {
    id: bookBackCover
    width: control.width
    height: control.height

    Component.onCompleted: {
      loadImage("qrc:///asset/img/side_book.svg")
    }

    onPaint: {
      let ctx = getContext('2d')
      ctx.reset()
      ctx.fillStyle = Qt.hsla(control.color[0], control.color[1], control.color[2], 0.4)
      ctx.beginPath()
      ctx.moveTo(8, 2)
      ctx.lineTo(control.width - 4, 2) // x: 26
      ctx.arcTo(control.width - 2, 3, control.width - 2, 6, 3) // x: 28 y: 3, x: 28 y: 6
      ctx.lineTo(control.width - 2, control.height - 4) // x: 28 y: 26
      ctx.arcTo(control.width - 2, control.height - 2, control.width - 4, control.height - 2, 3) // x: 28 y: 28, x: 26 y: 28
      ctx.lineTo(8, control.height - 2) // y: 28
      ctx.lineTo(8, 3)
      ctx.closePath()
      ctx.fill()

      ctx.drawImage("qrc:///asset/img/side_book.svg", 0, 0, 2, 26, 6, 2, 2, control.height - 4)
    }
  }

  /*Canvas {
    id: bookContentPreview
    width: 30
    height: 30
    antialiasing: true

    onPaint: {
      let ctx = getContext('2d')

      let gradient = ctx.createLinearGradient(25, 0, 28, 0)
      gradient.addColorStop(0.0, '#a6a6a6')
      gradient.addColorStop(1.0, '#f2f2f2')
      ctx.fillStyle = gradient
      ctx.beginPath()
      ctx.moveTo(23, 2)
      ctx.lineTo(25, 2)
      ctx.arcTo(28, 3, 28, 6, 3)
      ctx.lineTo(28, 26)
      ctx.arcTo(28, 28, 25, 28, 3)
      ctx.lineTo(23, 28)
      ctx.lineTo(23, 2)
      ctx.closePath()
      ctx.fill()
      ctx.restore()

      ctx.fillStyle = 'white'
      ctx.beginPath()
      ctx.moveTo(8, 2)
      ctx.lineTo(23, 2)
      ctx.arcTo(25, 3, 25, 6, 3)
      ctx.lineTo(25, 26)
      ctx.arcTo(25, 28, 23, 28, 3)
      ctx.lineTo(8, 28)
      ctx.lineTo(8, 2)
      ctx.closePath()
      ctx.fill()
      ctx.fillStyle = 'gray'
    }
  }*/

  Canvas {
    id: bookFrontCover
    width: control.width
    height: control.height

    onPaint: {
      let ctx = bookFrontCover.getContext('2d')
      ctx.reset()
      ctx.fillStyle = Qt.hsla(control.color[0], control.color[1], control.color[2], 0.6) //'hsla(0, 100%, 50%, 0.25)'
      ctx.beginPath()
      ctx.moveTo(6, 2)
      ctx.lineTo(control.width - 7, 2) // x: 23

      ctx.arcTo(control.width - 5, 3, control.width - 5, 6, 3) // x: 25, x: 25
      ctx.lineTo(control.width - 5, control.height - 4) // x: 25 y: 26
      ctx.arcTo(control.width - 5, control.height - 2, control.width - 7, control.height - 2, 3) // x: 25 y: 28, x: 23 y: 28
      ctx.lineTo(6, control.height - 2) // y: 28
      ctx.lineTo(6, 3)
      ctx.closePath()
      ctx.fill()
    }

    transform: Rotation {
      origin.x: 5
      origin.y: 5
      axis { x: 0; y: 1; z: 0 }
      angle: 0

      Behavior on angle {
        NumberAnimation { duration: 200; easing.type: Easing.OutCubic }
      }
    }
  }
}
