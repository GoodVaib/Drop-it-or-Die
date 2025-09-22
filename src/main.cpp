#include <iostream>
#include <string>
#include <cmath>
#include <cstdlib>
#include <ctime>

#include <SFML/Graphics.hpp>
#include <SFML/System.hpp>
#include <SFML/Window.hpp>

#include <TGUI/TGUI.hpp>
#include <TGUI/Backend/SFML-Graphics.hpp>

/////////////////////

using namespace std;
using namespace tgui;
using namespace sf;

/////////////////////


// variables
static short score_pl1_short = 0, score_pl2_short = 0, \
number_cubes_pl1, number_cubes_pl2, \
number_cube1_pl1, number_cube2_pl1, \
number_cube1_pl2, number_cube2_pl2;

static short shoots_pl1, shoots_pl2;

short who_win; // pl1 - 1; pl2 - 2

static string pl1_name = "pl1", pl2_name = "pl2";


void game();
void rand_game();

// main func
int main() {
    srand(time(NULL));

    game();
}

void game()
{
    RenderWindow window{VideoMode{ {1024, 512} }, "Drop it or Die"};
    window.setFramerateLimit(60);
    Gui gui{window};

    auto theme = tgui::Theme::create("./assets/themes/theme.txt");
    auto font = "./assets/fonts/Hero-Bold.ttf";

    auto texture_hand_pl1 = tgui::Texture("./assets/textures/game/hands/hand_blue.png");
    auto texture_hand_pl2 = tgui::Texture("./assets/textures/game/hands/hand_red.png");
    auto glass_up = tgui::Texture("./assets/textures/game/cup/glass_up.png");
    auto glass_down = tgui::Texture("./assets/textures/game/cup/glass_down.png");

    auto cup_pl1 = tgui::Picture::create(glass_up); gui.add(cup_pl1);
    cup_pl1->setOrigin(0.5, 0.5);
    cup_pl1->setSize(150, 150); //("14,64%", "29,29%");
    cup_pl1->setPosition("54,39%", "83,2%");

    auto cup_pl2 = tgui::Picture::create(glass_up); gui.add(cup_pl2);
    cup_pl2->setOrigin(0.5, 0.5);
    cup_pl2->setSize(150, 150); //("14,64%", "29,29%");
    cup_pl2->setPosition("45,61%", "16,8%");

    auto left_hand_pl1 = tgui::Picture::create(texture_hand_pl1); gui.add(left_hand_pl1);
    left_hand_pl1->setOrigin(0.5, 0.5);
    left_hand_pl1->setSize(100, 100);
    left_hand_pl1->setPosition("36,33%", "87,11%");
    //left_hand_pl1->getRenderer()->setTexture("image2.png");

    auto right_hand_pl1 = tgui::Picture::create(texture_hand_pl1); gui.add(right_hand_pl1);
    right_hand_pl1->setOrigin(0.5, 0.5);
    right_hand_pl1->setSize(100, 100);
    right_hand_pl1->setPosition("63,67%", "88,08%");

    auto left_hand_pl2 = tgui::Picture::create(texture_hand_pl2); gui.add(left_hand_pl2);
    left_hand_pl2->setOrigin(0.5, 0.5);
    left_hand_pl2->setSize(100, 100);
    left_hand_pl2->setPosition("63,67%", "20,70%");

    auto right_hand_pl2 = tgui::Picture::create(texture_hand_pl2); gui.add(right_hand_pl2);
    right_hand_pl2->setOrigin(0.5, 0.5);
    right_hand_pl2->setSize(100, 100);
    right_hand_pl2->setPosition("36,33%", "21,29%");

    // pl1 score
    auto score_pl1_text = tgui::Label::create(); gui.add(score_pl1_text);
    string full_text_pl1_score = "(" + pl1_name + ") score: " + to_string(score_pl1_short);
    score_pl1_text->setText(full_text_pl1_score);

    score_pl1_text->getRenderer()->setTextColor(tgui::Color::White);
    score_pl1_text->getRenderer()->setFont(font);
    score_pl1_text->setPosition("1%", "2%");
    score_pl1_text->setTextSize(16);
    score_pl1_text->setOrigin(0, 0);

    // pl2 score
    auto score_pl2_text = tgui::Label::create("Score: 0"); gui.add(score_pl2_text);
    string full_text_pl2_score = "(" + pl2_name + ") score: " + to_string(score_pl2_short);
    score_pl2_text->setText(full_text_pl2_score);

    score_pl2_text->getRenderer()->setTextColor(tgui::Color::White); 
    score_pl2_text->getRenderer()->setFont(font);
    score_pl2_text->setPosition("99%", "2%");
    score_pl2_text->setTextSize(16);
    score_pl2_text->setOrigin(1, 0);

    // start button
    auto start_btn = Button::create(); gui.add(start_btn);
    start_btn->setSize(121, 42);
    start_btn->setTextSize(31);
    start_btn->setOrigin(0.5, 0.5);
    start_btn->setPosition("50%", "50%"); // center window - origin (0.5,0.5)

    start_btn->onPress([&]{
        rand_game();

        if (number_cubes_pl1 > number_cubes_pl2){
            cout << "\n-------------- Who Win?\n" << "pl1(" << number_cubes_pl1 << ")" << " > " << "pl2(" << number_cubes_pl2 << ")\n";
            cout << "pl1 is win" << endl;

            score_pl1_short++;
            full_text_pl1_score = "(" + pl1_name + ") score: " + to_string(score_pl1_short);
            score_pl1_text->setText(full_text_pl1_score);
        }
        else if (number_cubes_pl1 < number_cubes_pl2){
            cout << "\n-------------- Who Win?\n" << "pl1(" << number_cubes_pl1 << ")" << " < " << "pl2(" << number_cubes_pl2 << ")\n";
            cout << "pl2 is win" << endl;
            
            score_pl2_short++;
            full_text_pl2_score = "(" + pl2_name + ") score: " + to_string(score_pl2_short);
            score_pl2_text->setText(full_text_pl2_score);
        }
        else if (number_cubes_pl1 = number_cubes_pl2){
            cout << "\n-------------- Who Win?\n" << "pl1(" << number_cubes_pl1 << ")" << " = " << "pl2(" << number_cubes_pl2 << ")\n";
            cout << "draw" << endl;
        }

    });


    // menu button
    auto btn_tap = Button::create("Menu"); gui.add(btn_tap);
    btn_tap->setRenderer(theme->getRenderer("gd_button"));
    btn_tap->setSize(121, 42);
    btn_tap->setTextSize(31);
    btn_tap->setOrigin(0, 1);
    btn_tap->setPosition("1%", "98%"); // left-down = origin (0,1)
    btn_tap->setEnabled(false);
    //btn_tap->setIgnoreMouseEvents(true);
    
    btn_tap->onPress([&]{
        score_pl1_short++;
        string full_text;
        full_text = "(" + pl1_name + ") score: " + to_string(score_pl1_short);
        score_pl1_text->setText(full_text);
    });
    
    
    while (window.isOpen())
    {
        while (const std::optional event = window.pollEvent()) {
            gui.handleEvent(*event);
            
            // quit - close window
            if (event->is<sf::Event::Closed>())
                window.close();
        }

        // render
        window.clear({62, 35, 0});
        gui.draw();
        window.display();
    }
}


void rand_game() {
    number_cube1_pl1 = rand() % (6 - 1 + 1) + 1;
    cout << "\n-------------- New Drop --------------\n" << "-------- pl1\n" << "number_cube1_pl1: " << number_cube1_pl1 << endl;
    number_cube2_pl1 = rand() % (6 - 1 + 1) + 1;
    cout << "number_cube2_pl1: " << number_cube2_pl1 << endl;

    cout << "       =\n";
    
    number_cubes_pl1 = number_cube1_pl1 + number_cube2_pl1;
    cout << "number_cubes_pl1: " << number_cubes_pl1 << endl << \
    "-------- pl2\n";

    number_cube1_pl2 = rand() % (6 - 1 + 1) + 1;
    cout << "number_cube1_pl2: " << number_cube1_pl2 << endl;
    number_cube2_pl2 = rand() % (6 - 1 + 1) + 1;
    cout << "number_cube2_pl2: " << number_cube2_pl2 << endl;

    cout << "       =\n";

    number_cubes_pl2 = number_cube1_pl2 + number_cube2_pl2;
    cout << "number_cubes_pl2: " << number_cubes_pl2 << endl;
}