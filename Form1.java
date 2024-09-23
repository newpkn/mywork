import java.awt.Container;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.Stack;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JTextArea;

public class Form1 extends JFrame implements ActionListener, KeyListener {

    Stack<String> st;
    Stack<String> redo;
    JTextArea t;
    JButton b1;
    JButton b2;

    public Form1() {
        st = new Stack<>();
        redo = new Stack<>();
        Container cp = this.getContentPane();
        cp.setLayout(null);

        t = new JTextArea();
        b1 = new JButton("UNDO");
        b2 = new JButton("REDO");
        t.setBounds(10, 10, 160, 80);
        b1.setBounds(10, 110, 70, 40);
        b2.setBounds(100, 110, 70, 40);

        cp.add(t);
        cp.add(b1);
        cp.add(b2);

        t.addKeyListener(this);
        b1.addActionListener(this);
        b2.addActionListener(this);

        setSize(200, 200);
        setResizable(false);
        setVisible(true);
        setLocationRelativeTo(null);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    }

    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == b1) {
            try{redo.push(st.peek());
                t.setText(st.pop());
            }
            catch(Exception er){
                t.setText("");
            }
        }

        if (e.getSource() == b2) {
            st.push(redo.peek());
            t.setText(redo.pop());
        }
    }

    public void keyTyped(KeyEvent e) {
        if (e.getKeyChar()==' ' || e.getKeyChar()== '\n') {
            st.push(t.getText());
        }
    }

    public void keyPressed(KeyEvent e) {
        
    }

    public void keyReleased(KeyEvent e) {
        
    }

    public static void main(String[] args) {
        new Form1();
    }
}