import { Elm } from "./Gaston/Main.elm";

const app = Elm.Gaston.Main.init();

app.ports.removeItem.subscribe((key) => {
    localStorage.removeItem(key);
});

app.ports.requestItem.subscribe((key) => {
    app.ports.receiveItem.send({ key, value: localStorage.getItem(key) });
});

app.ports.setItem.subscribe((item) => {
    localStorage.setItem(item.key, item.value);
});
