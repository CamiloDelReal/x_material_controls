import QtQuick 2.12
import QtQuick.Controls 2.12

PathView {
    id: carouselCtrl
    clip: true
    snapMode: PathView.SnapOneItem
    currentIndex: 0
    interactive: modelCount > 1

    property bool horizontal: true

    property int modelCount: (model !== undefined
                              ? (model.count
                                 ? model.count
                                 : (model.length ? model.length : 0))
                              : 0)

    path: Path {
        startX: (carouselCtrl.modelCount === 1
                 ? carouselCtrl.width / 2
                 : (carouselCtrl.horizontal
                    ? -carouselCtrl.width / 2
                    : carouselCtrl.width / 2))
        startY: (carouselCtrl.modelCount === 1
                 ? carouselCtrl.height / 2
                 : (carouselCtrl.horizontal
                    ? carouselCtrl.height / 2
                    : -carouselCtrl.height / 2))
        PathLine {
            x: (carouselCtrl.modelCount === 1
                ? carouselCtrl.width / 2
                : (carouselCtrl.horizontal
                   ? carouselCtrl.modelCount * carouselCtrl.width - carouselCtrl.width / 2
                   : carouselCtrl.width / 2))
            y: (carouselCtrl.modelCount === 1
                ? carouselCtrl.height
                : (carouselCtrl.horizontal
                   ? carouselCtrl.height / 2
                   : carouselCtrl.modelCount * carouselCtrl.height - carouselCtrl.height / 2))
        }
    }
}
