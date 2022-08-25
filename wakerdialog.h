#ifndef WAKERDIALOG_H
#define WAKERDIALOG_H

#include <QDialog>
#include <QDebug>
#include <QSystemTrayIcon>
#include <qt_windows.h>
#include <QAction>
#include <QMenu>
#include <QTime>
#include <QTimer>
#include <QtGui>
#include <QCheckBox>
#include <QSpinBox>


QT_BEGIN_NAMESPACE
namespace Ui { class WakerDialog; }
QT_END_NAMESPACE

class WakerDialog : public QDialog
{
    Q_OBJECT

public:
    WakerDialog(QWidget *parent = nullptr);
    ~WakerDialog();

    void keyDown(DWORD key);

    static void pressKey(DWORD vkKeyCode);

public slots:
    void OnTimerCallBack();
    void timeKeeperDefaultCheckSlot(bool);
    void userInputDefaultCheckSlot(bool);
    void quitSlot();
    void minimizedSlot();

protected:
    void closeEvent(QCloseEvent *event) override;

private:
    void initilize();
    void createActions();
    void createTrayIcon();
    void createTimer();


    Ui::WakerDialog *ui;

    HHOOK hhkLowLevelKybd;
    QSystemTrayIcon *trayIcon;
    QTimer *timer;

    QCheckBox *cbTimeKeeperDefault;
    QCheckBox *cbUserInputDefault;
    QSpinBox *sbTimeKeeperInterval;
    QSpinBox *sbUserInputInterval;
    QPushButton *btnQuit;
    QPushButton *btnMinimized;


    QAction *titleAction;
    QAction *quitAction;
    QMenu *trayIconMenu;

};
#endif // WAKERDIALOG_H
