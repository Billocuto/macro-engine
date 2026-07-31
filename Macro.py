from tkinter import *
import keyboard
import threading
import time
import pyautogui


# ================= CONFIG =================

pyautogui.FAILSAFE = False

ativo = False
modo_atual = "TODO"

MODOS = {
    "TODO": {
        "tecla_ativar": "2",
        "tecla_enviar": ["2"],
        "delay": 0.70
    },

    "ITADORI": {
        "tecla_ativar": "3",
        "tecla_enviar": ["3"],
        "delay": 0.31
    }
}


perfect_boogie_ativo = False
boogie_delay = 0.6

last_press = {}


# ================= FUNÇÕES =================


def aplicar_modo(nome):

    global modo_atual

    modo_atual = nome

    status_modo.config(
        text=f"MODO: {nome}"
    )

    config = MODOS[nome]

    config_label.config(
        text=f"ATIVAR: {config['tecla_ativar']} | "
             f"ENVIAR: {''.join(config['tecla_enviar'])} | "
             f"DELAY: {config['delay']}"
    )


    if nome == "TODO":
        boogie_frame.pack(pady=5)

    else:
        boogie_frame.pack_forget()



def toggle_modo():

    if modo_atual == "TODO":

        aplicar_modo("ITADORI")
        botao_modo.config(text="[ TODO ]")

    else:

        aplicar_modo("TODO")
        botao_modo.config(text="[ ITADORI ]")



def executar_tecla():

    config = MODOS[modo_atual]

    time.sleep(config["delay"])

    for tecla in config["tecla_enviar"]:
        keyboard.press_and_release(tecla)



def boogie_mouse_click():

    time.sleep(boogie_delay)

    pyautogui.click()



def ao_pressionar(event):

    global last_press

    if not ativo:
        return


    tecla = event.name

    agora = time.time()


    if tecla in last_press:

        if agora - last_press[tecla] < 0.08:
            return


    last_press[tecla] = agora


    # Macro principal
    if tecla == MODOS[modo_atual]["tecla_ativar"]:

        threading.Thread(
            target=executar_tecla,
            daemon=True
        ).start()


    # Perfect Boogie apenas no TODO
    if (
        modo_atual == "TODO"
        and perfect_boogie_ativo
        and tecla == "r"
    ):

        threading.Thread(
            target=boogie_mouse_click,
            daemon=True
        ).start()



    if (
        modo_atual == "TODO"
        and perfect_boogie_ativo
        and tecla == "r"
    ):

        threading.Thread(
            target=boogie_mouse_click,
            daemon=True
        ).start()




def ativar():

    global ativo

    ativo = True

    status_label.config(
        text="STATUS: ONLINE",
        fg="#00ff00"
    )




def desativar():

    global ativo

    ativo = False

    status_label.config(
        text="STATUS: OFFLINE",
        fg="#ff0000"
    )




def toggle_boogie():

    global perfect_boogie_ativo


    perfect_boogie_ativo = not perfect_boogie_ativo


    boogie_label.config(
        text=f"PERFECT BOOGIE: "
             f"{'ON' if perfect_boogie_ativo else 'OFF'}"
    )



# ================= INTERFACE =================


janela = Tk()

janela.title(
    "SYSTEM // MACRO ENGINE"
)

janela.geometry(
    "420x380"
)

janela.configure(
    bg="black"
)

janela.resizable(
    False,
    False
)



fonte = (
    "Consolas",
    11
)

fonte_titulo = (
    "Consolas",
    16,
    "bold"
)



borda = Frame(
    janela,
    bg="#00ff00",
    padx=2,
    pady=2
)

borda.pack(
    expand=True,
    fill="both",
    padx=10,
    pady=10
)



tela = Frame(
    borda,
    bg="black"
)

tela.pack(
    expand=True,
    fill="both"
)



Label(
    tela,
    text="MACRO ENGINE",
    fg="#00ff00",
    bg="black",
    font=fonte_titulo
).pack(pady=8)



status_label = Label(
    tela,
    text="STATUS: OFFLINE",
    fg="#ff0000",
    bg="black",
    font=fonte
)

status_label.pack()



status_modo = Label(
    tela,
    text="MODO: TODO",
    fg="#00ff00",
    bg="black",
    font=fonte
)

status_modo.pack()



config_label = Label(
    tela,
    text="",
    fg="#00ff00",
    bg="black"
)

config_label.pack()



def criar_botao(txt, cmd):

    return Button(
        tela,
        text=txt,
        command=cmd,
        bg="black",
        fg="#00ff00",
        activebackground="#00ff00",
        activeforeground="black",
        width=30
    )



criar_botao(
    ">> ENABLE SYSTEM",
    ativar
).pack(pady=4)



criar_botao(
    ">> DISABLE SYSTEM",
    desativar
).pack(pady=4)



botao_modo = criar_botao(
    "[ TODO ]",
    toggle_modo
)

botao_modo.pack(pady=4)



criar_botao(
    "[ ITADORI ]",
    lambda: aplicar_modo("ITADORI")
).pack(pady=3)



boogie_frame = Frame(
    tela,
    bg="black"
)



boogie_label = Label(
    boogie_frame,
    text="PERFECT BOOGIE: OFF",
    fg="#00ff00",
    bg="black"
)

boogie_label.pack()



criar_botao(
    "TOGGLE BOOGIE",
    toggle_boogie
).pack()



boogie_frame.pack(pady=5)



rgb_colors = [
    "#ff0000",
    "#00ff00",
    "#0000ff"
]


def animar_rgb(i=0):

    rgb_label.config(
        fg=rgb_colors[i % 3]
    )

    janela.after(
        300,
        animar_rgb,
        i+1
    )



rgb_label = Label(
    janela,
    text="By Gaara",
    bg="black",
    font=(
        "Consolas",
        10,
        "bold"
    )
)

rgb_label.place(
    relx=1,
    rely=1,
    x=-10,
    y=-10,
    anchor="se"
)


animar_rgb()



# ================= KEYBOARD =================


keyboard.on_press(
    ao_pressionar
)



def fechar():

    keyboard.unhook_all()

    janela.destroy()



janela.protocol(
    "WM_DELETE_WINDOW",
    fechar
)



aplicar_modo(
    "TODO"
)


janela.mainloop()
