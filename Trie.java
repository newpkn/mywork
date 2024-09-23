import java.util.Hashtable;
import java.util.Map;

public class Trie {

    Node root = new Node();
    public void insert(String word){

	word = word.toLowerCase();

        Node curr = root ;
        
        for (int i = 0 ; i < word.length() ; i++) {
            Character c = word.charAt(i);
            if(!(curr.children.containsKey(c))){
                Node tmp = new Node();
                curr.children.put(c, tmp);
            }
            curr = curr.children.get(c);
        }
        curr.flag = true ;
    }

    public void PrintWord(){
        boolean last = false;
        System.out.println("root --+ ");
        int i = 0 ;
        for (Character key : root.children.keySet()) {
            i++;
            System.out.println("       +- " + key);
            if (i == root.children.size())
                last = true;
            printWordsFromNode(root.children.get(key), " ",last);
        }
    }
    private void printWordsFromNode(Node node, String prefix, boolean last) {
        if(last) prefix+="  " ;
        else prefix+="| " ;
        for (Map.Entry<Character, Node> entry : node.children.entrySet()) {
            char c = entry.getKey();
            Node childNode = entry.getValue();
            printWordsFromNode(childNode, prefix + c,last);
        }
}

    public void PrintTrie(){
        boolean last = false;
        System.out.println("root --+ ");
        int i = 0 ;
        for (Character key : root.children.keySet()) {
            i++;
            System.out.println("       +- " + key);
            if (i == root.children.size())
                last = true;
            PrintTrie(root.children.get(key),"",last);
        }
    }

    private void PrintTrie(Node d, String indent, boolean last)
    {
        int i = 0;
        boolean tmp = false;
        if(last) indent+="  " ;
        else indent+="| " ;
        for (Character key : d.children.keySet()) {
            i++;
            System.out.println("       "+indent+"+- " + key);
            if (i == d.children.size())
                tmp = true;
            PrintTrie(d.children.get(key),indent,tmp);
        }
    }
}

class Node{
    boolean flag ;
    Hashtable<Character,Node> children ;

    public Node(){
        flag = false ;
        children = new Hashtable<>();
    }

        public static void main(String[] args) {
            Trie t = new Trie();
            t.insert("car");
            t.insert("cat");
            t.insert("bat");
            t.insert("brid");
            t.PrintWord();
    }
}