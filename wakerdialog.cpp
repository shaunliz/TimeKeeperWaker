#include "wakerdialog.h"
#include "ui_wakerdialog.h"


WakerDialog * wdRef;
QTime lastInputTime;
QTime currentTime;

#define IDLE_DURATION  100 // sec. - 해당 초만큼 입력이 없었으면, VK_xxx 전송
#define TIMER_DURATION (2*60*1000) // msec. - 2분 마다 체크.

LRESULT CALLBACK LowLevelKeyboardProc(int nCode, WPARAM wParam, LPARAM lParam)
{
    if (nCode == HC_ACTION)
    {
        qDebug() << "LowLevelKeyboardProc() / HC_ACTION";

        switch (wParam)
        {
            // Pass KeyDown/KeyUp messages for Qt class to logicize
            case WM_KEYDOWN:
                wdRef->keyDown(PKBDLLHOOKSTRUCT(lParam)->vkCode);
            break;

            /*
            case WM_KEYUP:
                wdRef->keyUp(PKBDLLHOOKSTRUCT(lParam)->vkCode);
            break;
            */
        }
    }
    return CallNextHookEx(NULL, nCode, wParam, lParam);
}

WakerDialog::WakerDialog(QWidget *parent)
    : QDialog(parent)
    , ui(new Ui::WakerDialog)
{
    ui->setupUi(this);

    wdRef = this;
    hhkLowLevelKybd = SetWindowsHookEx(WH_KEYBOARD_LL /*WH_MOUSE_LL*/, LowLevelKeyboardProc, 0, 0);

    initilize();
    createActions();
    createTrayIcon();
    trayIcon->show();

    // createTimer(); // minimize 구간으로 이동
}

WakerDialog::~WakerDialog()
{
    delete ui;
}

void WakerDialog::keyDown(DWORD key)
{
    qDebug() << "key down:" << key;
    lastInputTime = QTime::currentTime();
}


void WakerDialog::pressKey(DWORD vkKeyCode)
{
    qDebug() << " WakerDialog::pressKey() ";

    INPUT Input;

    // Set up a generic keyboard event.
    Input.type = INPUT_KEYBOARD;
    Input.ki.wScan = 0;
    Input.ki.time = 0;
    Input.ki.dwExtraInfo = 0;
    /* Input.ki.dwFlags = 0; */

    Input.ki.wVk = vkKeyCode;
    SendInput(1, &Input, sizeof(INPUT));

    Input.ki.dwFlags = KEYEVENTF_KEYUP; //0;
    SendInput(1, &Input, sizeof(INPUT));
}


void WakerDialog::OnTimerCallBack()
{
    currentTime = QTime::currentTime();

    qDebug() << "OnTimerCallBack() / current time:" << currentTime;
    qDebug() << "last input time:" << lastInputTime << "\n diff:" << currentTime.secsTo(lastInputTime)
             << " / diff:" << lastInputTime.secsTo(currentTime) << " / " << sbUserInputInterval->value();

    if(lastInputTime.secsTo(currentTime) > sbUserInputInterval->value())
    {
        pressKey(VK_SHIFT);
    }
}

void WakerDialog::timeKeeperDefaultCheckSlot(bool checked)
{
    qDebug() << "timeKeeperDefaultCheckSlot:" << checked;

    if(checked)
    {
        this->sbTimeKeeperInterval->setValue(120);
        this->sbTimeKeeperInterval->setDisabled(true);
    }
    else
    {
        this->sbTimeKeeperInterval->setEnabled(true);
    }
}

void WakerDialog::userInputDefaultCheckSlot(bool checked)
{
    qDebug() << "userInputDefaultCheckSlot:" << checked;

    if(checked)
    {
        this->sbUserInputInterval->setValue(100);
        this->sbUserInputInterval->setDisabled(true);
    }
    else
    {
        this->sbUserInputInterval->setEnabled(true);
    }
}

void WakerDialog::quitSlot()
{
    QApplication::quit();
}


void WakerDialog::minimizedSlot()
{
    QDialog::close();
}

/* protected */
void WakerDialog::closeEvent(QCloseEvent *evt)
{
    qDebug() << "WakerDialog::closeEvent()";

    createTimer();
}



/* private */
void WakerDialog::initilize()
{
    cbTimeKeeperDefault = ui->cbTimeKeeperDefault;
    cbUserInputDefault = ui->cbUserInputDefault;
    sbTimeKeeperInterval = ui->sbTimeKeeperInterval;
    sbUserInputInterval = ui->sbUserInputInterval;
    btnQuit = ui->btnQuit;
    btnMinimized = ui->btnMinimized;


    if(cbTimeKeeperDefault->isChecked())
    {
        sbTimeKeeperInterval->setValue(120);
        sbTimeKeeperInterval->setDisabled(true);
    }
    else
    {
        sbTimeKeeperInterval->setEnabled(true);
    }

    if(cbUserInputDefault->isChecked())
    {
        sbUserInputInterval->setValue(100);
        sbUserInputInterval->setDisabled(true);
    }
    else
    {
        sbUserInputInterval->setEnabled(true);
    }
}


void WakerDialog::createActions()
{
    titleAction = new QAction(tr("&TimeKeeper Waker"), this);
    quitAction = new QAction(tr("&Quit"), this);

    connect(quitAction, &QAction::triggered, qApp, &QCoreApplication::quit);
    connect(cbTimeKeeperDefault, SIGNAL(toggled(bool)), this, SLOT(timeKeeperDefaultCheckSlot(bool)));
    connect(cbUserInputDefault, SIGNAL(toggled(bool)), this, SLOT(userInputDefaultCheckSlot(bool)));
    connect(btnQuit, SIGNAL(clicked()), this, SLOT(quitSlot()));
    connect(btnMinimized, SIGNAL(clicked()), this, SLOT(minimizedSlot()));

}


void WakerDialog::createTrayIcon()
{
    qDebug() << "WakerDialog::createTrayIcon()";

    trayIconMenu = new QMenu(this);
    trayIconMenu->addAction(titleAction);
    trayIconMenu->addSeparator();
    trayIconMenu->addAction(quitAction);

    trayIcon = new QSystemTrayIcon(this);
    QIcon icon(":/images/heart.png");
    trayIcon->setIcon(icon);
    trayIcon->setContextMenu(trayIconMenu);
}


void WakerDialog::createTimer()
{
    timer = new QTimer();
    lastInputTime = QTime::currentTime();
    connect(timer, SIGNAL(timeout()), this, SLOT(OnTimerCallBack()));


    // timer->start(TIMER_DURATION);
    qDebug() << "sbTimeKeeperInterval->value():" << sbTimeKeeperInterval->value();

    timer->start(sbTimeKeeperInterval->value() * 1000);
}


