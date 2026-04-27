from tkinter import *
import keyboard
import threading
import time
import sys
import pyautogui

# ---- fix pyautogui ----
pyautogui.FAILSAFE = False

ativo = False

# ---- MODOS ----
MODOS = {
    "TODO": {
        "tecla_ativar": "2",
        "tecla_enviar": "2",
        "delay": 0.70
    },
    "ITADORI": {
        "tecla_ativar": "3",
        "tecla_enviar": "23",
        "delay": 0.31
    }
}

modo_atual = "TODO"

# ---- PERFECT BOOGIE ----
perfect_boogie_ativo = False
boogie_delay = 0.6

last_press = {}

def aplicar_modo(nome):
    global modo_atual
    modo_atual = nome

    status_modo.config(text=f"MODO: {nome}")

    config = MODOS[nome]
    config_label.config(
        text=f"ATIVAR: {config['tecla_ativar']} | ENVIAR: {config['tecla_enviar']} | DELAY: {config['delay']}"
    )

    if nome == "TODO":
        boogie_frame.pack(pady=5)
    else:
        boogie_frame.forget()

def toggle_modo():
    if modo_atual == "TODO":
        aplicar_modo("ITADORI")
        botao_modo.config(text="[ ITADORI ]")
    else:
        aplicar_modo("TODO")
        botao_modo.config(text="[ TODO ]")

def executar_tecla():
    config = MODOS[modo_atual]
    time.sleep(config["delay"])
    keyboard.press_and_release(config["tecla_enviar"])

def boogie_mouse_click():
    time.sleep(boogie_delay)
    pyautogui.click(button='left')

def ao_pressionar(event):
    global last_press

    if not ativo:
        return

    tecla = event.name

    now = time.time()
    if tecla in last_press and now - last_press[tecla] < 0.08:
        return
    last_press[tecla] = now

    if tecla == "2":
        threading.Thread(target=executar_tecla, daemon=True).start()

    if modo_atual == "TODO" and perfect_boogie_ativo:
        if tecla == "r":
            threading.Thread(target=boogie_mouse_click, daemon=True).start()

def ativar():
    global ativo
    ativo = True
    status_label.config(text="STATUS: ONLINE", fg="#00ff00")

def desativar():
    global ativo
    ativo = False
    status_label.config(text="STATUS: OFFLINE", fg="#ff0000")

def toggle_boogie():
    global perfect_boogie_ativo
    perfect_boogie_ativo = not perfect_boogie_ativo

    boogie_label.config(
        text=f"PERFECT BOOGIE: {'ON' if perfect_boogie_ativo else 'OFF'}"
    )

# ---- UI ----
janela = Tk()
janela.title("SYSTEM // MACRO ENGINE")
janela.geometry("420x380")
janela.configure(bg="black")
janela.resizable(False, False)

fonte = ("Consolas", 11)
fonte_titulo = ("Consolas", 16, "bold")

borda = Frame(janela, bg="#00ff00", padx=2, pady=2)
borda.pack(expand=True, fill="both", padx=10, pady=10)

tela = Frame(borda, bg="black")
tela.pack(expand=True, fill="both")

Label(tela, text="MACRO ENGINE", fg="#00ff00", bg="black", font=fonte_titulo).pack(pady=8)

status_label = Label(tela, text="STATUS: OFFLINE", fg="#ff0000", bg="black", font=fonte)
status_label.pack(pady=3)

status_modo = Label(tela, text="MODO: TODO", fg="#00ff00", bg="black", font=fonte)
status_modo.pack(pady=3)

config_label = Label(tela, text="", fg="#00ff00", bg="black", font=("Consolas", 9))
config_label.pack(pady=3)

def botao(texto, comando):
    return Button(
        tela,
        text=texto,
        command=comando,
        bg="black",
        fg="#00ff00",
        activebackground="#00ff00",
        activeforeground="black",
        font=fonte,
        relief="flat",
        bd=0,
        highlightthickness=1,
        highlightbackground="#00ff00",
        width=30
    )

botao(">> ENABLE SYSTEM", ativar).pack(pady=4)
botao(">> DISABLE SYSTEM", desativar).pack(pady=4)

botao_modo = Button(
    tela,
    text="[ TODO ]",
    command=toggle_modo,
    bg="black",
    fg="#00ff00",
    activebackground="#00ff00",
    activeforeground="black",
    font=fonte,
    relief="flat",
    bd=0,
    highlightthickness=1,
    highlightbackground="#00ff00",
    width=30
)
botao_modo.pack(pady=4)

Button(
    tela,
    text="[ ITADORI ]",
    command=lambda: aplicar_modo("ITADORI"),
    bg="black",
    fg="#00ff00",
    activebackground="#00ff00",
    activeforeground="black",
    font=fonte,
    relief="flat",
    bd=0,
    highlightthickness=1,
    highlightbackground="#00ff00",
    width=30
).pack(pady=3)

boogie_frame = Frame(tela, bg="black")

boogie_label = Label(
    boogie_frame,
    text="PERFECT BOOGIE: OFF",
    fg="#00ff00",
    bg="black",
    font=fonte
)
boogie_label.pack()

Button(
    boogie_frame,
    text="TOGGLE BOOGIE",
    command=toggle_boogie,
    bg="black",
    fg="#00ff00",
    activebackground="#00ff00",
    activeforeground="black",
    font=fonte,
    relief="flat",
    bd=0,
    highlightthickness=1,
    highlightbackground="#00ff00",
    width=30
).pack(pady=3)

rgb_colors = ["#ff0000", "#00ff00", "#0000ff"]

def animar_rgb(i=0):
    rgb_label.config(fg=rgb_colors[i % len(rgb_colors)])
    janela.after(300, animar_rgb, i + 1)

rgb_label = Label(
    janela,
    text="By Gaara",
    bg="black",
    font=("Consolas", 10, "bold")
)
rgb_label.place(relx=1.0, rely=1.0, x=-10, y=-10, anchor="se")

animar_rgb()


def iniciar_keyboard():
    keyboard.on_press(ao_pressionar)

threading.Thread(target=iniciar_keyboard, daemon=True).start()

aplicar_modo("TODO")

janela.mainloop()