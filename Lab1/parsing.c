#include <stdlib.h>
#include <stdbool.h>

#include "parsing.h"
#include "parser.h"
#include "command.h"

static scommand parse_scommand(Parser p) {
    scommand nc = scommand_new();
    arg_kind_t arg_type;
    char *arg = parser_next_argument(p, &arg_type);
    
    while(arg != NULL)
    {
       
        if(arg_type == ARG_NORMAL)
        {
            scommand_push_back(nc, arg);
        }
        else if (arg_type == ARG_INPUT)
        {
            scommand_set_redir_in(nc, arg);

        }
        else if (arg_type == ARG_OUTPUT)
        {
           scommand_set_redir_out(nc, arg);
        }
        
        arg = parser_next_argument(p, &arg_type);

    }

    if(arg_type == ARG_INPUT || arg_type == ARG_OUTPUT || scommand_is_empty(nc))
    {
        nc = scommand_destroy(nc);
        nc = NULL;
    }


    return nc;
}

pipeline parse_pipeline(Parser p) {
    if(parser_at_eof(p) || p == NULL)
    {
        fprintf(stderr, "Unable to start de parsing from sdtin");
        exit(EXIT_FAILURE);
    }

    pipeline result = pipeline_new();
    scommand cmd = NULL;
    bool error = false, another_pipe=true;
    bool is_background; // bool opcional p/background
    
    while (another_pipe && !error) {

        cmd = parse_scommand(p);
        error = (cmd==NULL); /* Comando inválido al empezar */
    
        if(!error)
        {
            pipeline_push_back(result, cmd);

            parser_op_pipe(p, &another_pipe);

        }
    
    }

    // Si no terminamos, busco un &
    if (!parser_at_eof(p)) {
            
        parser_op_background(p, &is_background);

        // Indico si debe esperar
        pipeline_set_wait(result, !is_background); 

        // Una vez pasado el &, borramos todo lo que sobre
        parser_skip_blanks(p); 
        parser_garbage(p, &error);
    }
    

    if(error || pipeline_is_empty(result))
    {
        result = pipeline_destroy(result);
        result = NULL;
    }

    return result;
}
