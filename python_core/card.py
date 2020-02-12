class card:

    def __init__(self, suit, point, index=-1):
        print("hello world")
        if index == -1:
            self.index = suit*13 + point
            self.suit = suit
            if point == 1:
                self.point = 14
            else:
                self.point = point
        else:
            self.index = index
            self.suit = int(index/13)
            if index % 13 + 1 == 1:
                self.point = 14
            else:
                self.point = index % 13 + 1

    def __eq__(self, o) -> bool:
        return self.index == o.index

    def __str__(self) -> str:
        suits = {0: "♠", 1: "♥", 2: "♣", 3: "♦"}
        points = {14: "A", 2: "2", 3: "3", 4: "4", 5: "5", 6: "6", 7: "7", 8: "8", 9: "9", 10: "10", 11: "J", 12: "Q",
                  13: "K"}
        return str(suits[self.suit])+points[self.point]


