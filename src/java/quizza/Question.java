package quizza;


import java.util.ArrayList;
import java.util.Collections;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author akumar
 */
public class Question {

    private String questionID;
    private String questionStatement;
    private ArrayList<String> options;

    public Question( String questionID ) {
        this.options = new ArrayList<>();
        this.questionID = questionID;
    }

    public void setQuestionID(String id) {
        this.options = new ArrayList<>();
        this.questionID = id;
    }

    public String getQuestionID() {
        return this.questionID;
    }

    public void setQuestionStatement(String q) {
        this.questionStatement = q;
    }

    public String getQuestionsStatement() {
        return this.questionStatement;
    }
    
    public void addOption( String option ){
        this.options.add( questionID + "@" + option);
        Collections.shuffle(this.options);
    }
    
    public String [] getOptions (){
        return this.options.toArray(new String[options.size()]);
    }

}
