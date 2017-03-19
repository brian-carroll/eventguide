.CardList  .Card {
    display: inline-block;
    margin-bottom: 32px;
}

.Card {
    vertical-align: top;
    width: 100%;
    border-radius: 2px;
    overflow: hidden;
    text-rendering: optimizeLegibility;
    transform: translateZ(0);
}

.Card:hover  .BgOverlay {
    opacity: 0;
}

@media only screen and (min-width: 480px) {
        .CardList {
    padding: 0 48px;
}
}

@media only screen and (min-width: 480px) {
        .Card {
    margin: 16px 14px 40px 14px;
    width: calc(100% / 2 - 32px);
}
}

@media only screen and (min-width: 800px) {
        .Card {
    width: calc(100% / 3 - 32px);
}
}

.BgOverlay {
    z-index: 1;
}

.BtnPlay {
    position: absolute;
    top: 50%;
    left: 50%;
    background-color: #424C55;
    transform: translate(-50%, -50%) scale(0.8);
}

.CardCover {
    position: relative;
    height: 250px;
    background-color: #dbdbdb;
    background-size: cover;
    background-position: center center;
    background-repeat: no-repeat;
    overflow: hidden;
}

.CardCover::after {
    display: block;
    content: ;
    width: 100%;
    padding-top: 56.25%;
}

.CardHeading {
    margin: 0.5rem 0;
    font-weight: 700;
}

.CardImage {
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    width: 100%;
}

.BgOverlay {
    position: absolute;
    top: 0;
    right: 0;
    bottom: 0;
    left: 0;
    transition: all 0.3s cubicBezier(0.215, 0.61, 0.355, 1);
    background-color: #424C55;
}

.BgOverlay_Video {
    background-image: url(/media/img/icon-play.png);
    background-repeat: no-repeat;
    background-position: 50% 50%;
    background-size: 15%;
}

.BgOverlay_75 {
    opacity: 0.75;
}

.BgOverlay_50 {
    opacity: 0.5;
}

.BgOverlay_25 {
    opacity: 0.25;
}
