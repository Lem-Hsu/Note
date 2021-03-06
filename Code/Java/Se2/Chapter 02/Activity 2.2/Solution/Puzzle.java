package localize;

import java.awt.Font;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Locale;
import java.util.ResourceBundle;
import javax.swing.*;

public class Puzzle extends JFrame implements ActionListener {

    JPanel jp;
    JComboBox city;
    JLabel l;

    public Puzzle() {
        jp = new JPanel();

        city = new JComboBox();
        city.addItem("Select");
        city.addItem("English");
        city.addItem("French");
        l = new JLabel("Select the language:");
        jp.add(l);
        jp.add(city);

        city.addActionListener(this);

        setTitle("Puzzle Game");
        setVisible(true);
        setSize(300, 200);
        add(jp);

    }

    @Override
    public void actionPerformed(ActionEvent e) {
        String str1 = city.getSelectedItem().toString();

        if (str1.equals("English")) {

            GameWindow gw=new GameWindow("English");
            

        }
        if (str1.equals("French")) {


            GameWindow gw=new GameWindow("French");
        }

    }

    public static void main(String[] args) {
        Puzzle cobj = new Puzzle();
    }
}

