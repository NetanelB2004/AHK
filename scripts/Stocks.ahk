#SingleInstance Force
!+^h::ShowStocks()

ShowStocks() {
    STOCKS_ARR := ["mu", "Costco", "Berkshire Hathaway", "spdr", "poet"]

    message := "
    (
    Invensted on 9/9/2024
    Mu - 4 shares at $87
    Costco - 1 share at $881
    Berkshire Hathaway - 2 shares at $447
    SPDR S&P 500 - 1 share at $543
    poet - 9 shares at $3.39
    )"

    for index, stock in STOCKS_ARR {
        Run, https://www.google.com/search?q=%stock% stock
    }

    sleep, 500
    MsgBox, % message
}